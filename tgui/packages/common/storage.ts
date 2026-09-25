/**
 * Browser-agnostic abstraction of key-value web storage.
 *
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

export const IMPL_MEMORY = 0;
export const IMPL_HUB_STORAGE = 1;
export const IMPL_IFRAME_INDEXED_DB = 2;
export const IMPL_INDEXED_DB = 3;

const INDEXED_DB_VERSION = 1;
const INDEXED_DB_NAME = 'tgui';
const INDEXED_DB_STORE_NAME = 'storage-v1';

const READ_ONLY = 'readonly';
const READ_WRITE = 'readwrite';

type StorageImplementation =
  | typeof IMPL_MEMORY
  | typeof IMPL_HUB_STORAGE
  | typeof IMPL_IFRAME_INDEXED_DB
  | typeof IMPL_INDEXED_DB;

type StorageBackend = {
  impl: StorageImplementation;
  get(key: string): Promise<any>;
  set(key: string, value: any): Promise<void>;
  remove(key: string): Promise<void>;
  clear(): Promise<void>;
};

export type StorageDiagnostic = {
  level: 'info' | 'warn' | 'error';
  message: string;
};

const testGeneric = (testFn: () => boolean) => (): boolean => {
  try {
    return Boolean(testFn());
  } catch {
    return false;
  }
};

const testHubStorage = testGeneric(
  () => window.hubStorage && !!window.hubStorage.getItem
);

// TODO: Remove with 516
// prettier-ignore
const testIndexedDb = testGeneric(() => (
  (window.indexedDB || window.msIndexedDB)
  && !!(window.IDBTransaction || window.msIDBTransaction)
));

const STORAGE_CDN_TIMEOUT = 5000;
const persistedStorageKeys = ['panel-settings', 'chat-state', 'chat-messages'];
const legacyHubMigrationKeys = ['panel-settings'];

class HubStorageBackend implements StorageBackend {
  public impl: StorageImplementation;

  constructor() {
    this.impl = IMPL_HUB_STORAGE;
  }

  async get(key: string): Promise<any> {
    const value = await window.hubStorage.getItem(key);
    if (typeof value === 'string') {
      return JSON.parse(value);
    }
    return undefined;
  }

  async set(key: string, value: any): Promise<void> {
    window.hubStorage.setItem(key, JSON.stringify(value));
  }

  async remove(key: string): Promise<void> {
    window.hubStorage.removeItem(key);
  }

  async clear(): Promise<void> {
    window.hubStorage.clear();
  }
}

class MemoryBackend implements StorageBackend {
  private store: Record<string, any>;
  public impl: StorageImplementation;

  constructor() {
    this.impl = IMPL_MEMORY;
    this.store = {};
  }

  async get(key: string): Promise<any> {
    return this.store[key];
  }

  async set(key: string, value: any): Promise<void> {
    this.store[key] = value;
  }

  async remove(key: string): Promise<void> {
    this.store[key] = undefined;
  }

  async clear(): Promise<void> {
    this.store = {};
  }
}

class IndexedDbBackend implements StorageBackend {
  public impl: StorageImplementation;
  public dbPromise: Promise<IDBDatabase>;

  constructor() {
    this.impl = IMPL_INDEXED_DB;
    this.dbPromise = new Promise((resolve, reject) => {
      const indexedDB = window.indexedDB || window.msIndexedDB;
      const req = indexedDB.open(INDEXED_DB_NAME, INDEXED_DB_VERSION);
      req.onupgradeneeded = () => {
        try {
          req.result.createObjectStore(INDEXED_DB_STORE_NAME);
        } catch (err) {
          reject(
            new Error(
              'Failed to upgrade IDB: ' +
                (err instanceof Error ? err.message : String(err))
            )
          );
        }
      };
      req.onsuccess = () => resolve(req.result);
      req.onerror = () => {
        reject(new Error('Failed to open IDB: ' + req.error));
      };
    });
  }

  private async getStore(mode: IDBTransactionMode): Promise<IDBObjectStore> {
    const db = await this.dbPromise;
    return db
      .transaction(INDEXED_DB_STORE_NAME, mode)
      .objectStore(INDEXED_DB_STORE_NAME);
  }

  async get(key: string): Promise<any> {
    const store = await this.getStore(READ_ONLY);
    return new Promise((resolve, reject) => {
      const req = store.get(key);
      req.onsuccess = () => resolve(req.result);
      req.onerror = () => reject(req.error);
    });
  }

  async set(key: string, value: any): Promise<void> {
    // NOTE: We deliberately make this operation transactionless
    const store = await this.getStore(READ_WRITE);
    store.put(value, key);
  }

  async remove(key: string): Promise<void> {
    // NOTE: We deliberately make this operation transactionless
    const store = await this.getStore(READ_WRITE);
    store.delete(key);
  }

  async clear(): Promise<void> {
    // NOTE: We deliberately make this operation transactionless
    const store = await this.getStore(READ_WRITE);
    store.clear();
  }
}

class IFrameIndexedDbBackend implements StorageBackend {
  public impl: StorageImplementation;

  private documentElement: HTMLIFrameElement;
  private iframeWindow: Window;

  constructor() {
    this.impl = IMPL_IFRAME_INDEXED_DB;
  }

  async ready(): Promise<boolean | null> {
    const iframe = document.createElement('iframe');
    iframe.style.display = 'none';
    iframe.allow = 'storage-access';
    iframe.src = Byond.storageCdn;

    const completePromise: Promise<boolean> = new Promise((resolve) => {
      const listener = (message: MessageEvent) => {
        if (
          message.source === iframe.contentWindow &&
          message.data === 'ready'
        ) {
          resolveReady(true);
        }
      };
      const resolveReady = (ready: boolean) => {
        clearTimeout(timeout);
        window.removeEventListener('message', listener);
        resolve(ready);
      };
      const timeout = setTimeout(
        () => resolveReady(false),
        STORAGE_CDN_TIMEOUT
      );

      fetch(Byond.storageCdn, { method: 'HEAD' })
        .then((response) => {
          if (response.status !== 200) {
            resolveReady(false);
          }
        })
        .catch(() => {
          resolveReady(false);
        });

      window.addEventListener('message', listener);
    });

    this.documentElement = document.body.appendChild(iframe);
    if (!this.documentElement.contentWindow) {
      return new Promise((res) => res(false));
    }

    this.iframeWindow = this.documentElement.contentWindow;

    return completePromise;
  }

  async get(key: string): Promise<any> {
    const promise = new Promise((resolve) => {
      const listener = (message: MessageEvent) => {
        if (
          message.source === this.iframeWindow &&
          message.data.key &&
          message.data.key === key
        ) {
          clearTimeout(timeout);
          window.removeEventListener('message', listener);
          resolve(message.data.value);
        }
      };
      const timeout = setTimeout(() => {
        window.removeEventListener('message', listener);
        resolve(undefined);
      }, STORAGE_CDN_TIMEOUT);

      window.addEventListener('message', listener);
    });

    this.iframeWindow.postMessage({ type: 'get', key: key }, '*');
    return promise;
  }

  async set(key: string, value: any): Promise<void> {
    this.iframeWindow.postMessage({ type: 'set', key: key, value: value }, '*');
  }

  async remove(key: string): Promise<void> {
    this.iframeWindow.postMessage({ type: 'remove', key: key }, '*');
  }

  async clear(): Promise<void> {
    this.iframeWindow.postMessage({ type: 'clear' }, '*');
  }

  async destroy(): Promise<void> {
    document.body.removeChild(this.documentElement);
  }
}

/**
 * Web Storage Proxy object, which selects the best backend available
 * depending on the environment.
 */
class StorageProxy implements StorageBackend {
  private backendPromise: Promise<StorageBackend>;
  public impl: StorageImplementation = IMPL_IFRAME_INDEXED_DB;
  public diagnostics: StorageDiagnostic[] = [];

  private log(level: StorageDiagnostic['level'], message: string) {
    console.error(message);
    this.diagnostics.push({ level, message });
  }

  constructor() {
    this.backendPromise = (async () => {
      // TODO: Remove with 516
      if (Byond.TRIDENT) {
        if (testIndexedDb()) {
          try {
            const backend = new IndexedDbBackend();
            await backend.dbPromise;
            return backend;
          } catch {}
        }

        this.log('warn', 'Enabling memory as last resort for 515');
        return new MemoryBackend();
      }

      // Prefer the configured iframe storage when available. hubStorage may
      // already be enabled by another window/server, but the iframe origin is
      // the server-configured storage boundary.
      if (Byond.storageCdn) {
        const iframe = new IFrameIndexedDbBackend();

        if ((await iframe.ready()) === true) {
          this.log('info', `Using iframe storage (${Byond.storageCdn})`);

          if (await iframe.get('byondstorage-migrated')) return iframe;

          const iframeHasPersistedStorage = (
            await Promise.all(
              persistedStorageKeys.map((setting) => iframe.get(setting))
            )
          ).some((settings) => settings !== undefined);

          if (!iframeHasPersistedStorage) {
            this.log(
              'info',
              'No existing iframe data, migrating from byondstorage'
            );
            const hubStorageWasEnabled = testHubStorage();
            if (!hubStorageWasEnabled) {
              Byond.winset(null, 'browser-options', '+byondstorage');

              await new Promise<void>((resolve) => {
                document.addEventListener(
                  'byondstorageupdated',
                  () => {
                    // This event is emitted *before* byondstorage is actually
                    // created, so we have to wait a little bit before using it.
                    setTimeout(resolve, 1);
                  },
                  { once: true }
                );
              });
            }

            const hub = new HubStorageBackend();

            // Migrate safe legacy settings from byondstorage to the IFrame.
            // Chat history may contain server-specific HTML/components from
            // other codebases that shared the old byondstorage namespace.
            await Promise.all(
              legacyHubMigrationKeys.map(async (setting) => {
                try {
                  const settings = await hub.get(setting);
                  if (settings !== undefined) {
                    await iframe.set(setting, settings);
                    this.log('info', `Migrated '${setting}' from byondstorage`);
                  }
                } catch {
                  this.log(
                    'warn',
                    `Failed to migrate '${setting}' from byondstorage`
                  );
                }
              })
            );

            if (!hubStorageWasEnabled) {
              Byond.winset(null, 'browser-options', '-byondstorage');
            }
          }

          await iframe.set('byondstorage-migrated', true);

          return iframe;
        }

        this.log(
          'warn',
          `Iframe storage failed to load from ${Byond.storageCdn}`
        );
        iframe.destroy();
      } else {
        this.log('info', 'No storage CDN configured');
      }

      if (testHubStorage()) {
        this.log('warn', 'Falling back to hubStorage (byondstorage)');
        return new HubStorageBackend();
      }

      // IFrame hasn't worked out for us, we'll need to enable byondstorage
      this.log('warn', 'Enabling byondstorage as last resort');
      Byond.winset(null, 'browser-options', '+byondstorage');

      return new Promise((resolve) => {
        const listener = () => {
          document.removeEventListener('byondstorageupdated', listener);

          // This event is emitted *before* byondstorage is actually created
          // so we have to wait a little bit before we can use it
          setTimeout(() => resolve(new HubStorageBackend()), 1);
        };

        document.addEventListener('byondstorageupdated', listener);
      });
    })();
  }

  async get(key: string): Promise<any> {
    const backend = await this.backendPromise;
    return backend.get(key);
  }

  async set(key: string, value: any): Promise<void> {
    const backend = await this.backendPromise;
    return backend.set(key, value);
  }

  async remove(key: string): Promise<void> {
    const backend = await this.backendPromise;
    return backend.remove(key);
  }

  async clear(): Promise<void> {
    const backend = await this.backendPromise;
    return backend.clear();
  }
}

export const storage = new StorageProxy();
