#!/usr/bin/env node
/**
 * Build script for /tg/station 13 codebase.
 *
 * This script uses Juke Build, read the docs here:
 * https://github.com/stylemistake/juke-build
 */

import fs from "fs";
import { get } from "http";
import { env } from "process";
import Juke from "./juke/index.js";
import { DreamDaemon, DreamMaker, NamedVersionFile } from "./lib/byond.js";
import { yarn } from "./lib/yarn.js";

Juke.chdir("../..", import.meta.url);
Juke.setup({ file: import.meta.url }).then((code) => {
  // We're using the currently available quirk in Juke Build, which
  // prevents it from exiting on Windows, to wait on errors.
  if (code !== 0 && process.argv.includes("--wait-on-error")) {
    Juke.logger.error("Please inspect the error and close the window.");
    return;
  }
  process.exit(code);
});

const DME_NAME = "shiptest";

export const DefineParameter = new Juke.Parameter({
  type: "string[]",
  alias: "D",
});

export const PortParameter = new Juke.Parameter({
  type: "string",
  alias: "p",
});

export const DmVersionParameter = new Juke.Parameter({
  type: "string",
});

export const CiParameter = new Juke.Parameter({ type: "boolean" });

export const WarningParameter = new Juke.Parameter({
  type: "string[]",
  alias: "W",
});

export const NoWarningParameter = new Juke.Parameter({
  type: "string[]",
  alias: "NW",
});

export const DmMapsIncludeTarget = new Juke.Target({
  executes: async () => {
    const folders = [
      ...Juke.glob("_maps/outpost/**/*.dmm"),
      ...Juke.glob("_maps/RandomRuins/**/*.dmm"),
      ...Juke.glob("_maps/shuttles/**/*.dmm"),
      ...Juke.glob("_maps/templates/**/*.dmm"),
    ];
    const content =
      folders
        .map((file) => file.replace("_maps/", ""))
        .map((file) => `#include "${file}"`)
        .join("\n") + "\n";
    fs.writeFileSync("_maps/templates.dm", content);
  },
});

export const DmTarget = new Juke.Target({
  parameters: [
    DefineParameter,
    DmVersionParameter,
    WarningParameter,
    NoWarningParameter,
  ],
  dependsOn: ({ get }) => [
    get(DefineParameter).includes("ALL_MAPS") && DmMapsIncludeTarget,
  ],
  inputs: [
    "_maps/map_files/**",
    "code/**",
    "html/**",
    "icons/**",
    "interface/**",
    `${DME_NAME}.dme`,
    NamedVersionFile,
  ],
  outputs: ({ get }) => {
    if (get(DmVersionParameter)) {
      return []; // Always rebuild when dm version is provided
    }
    return [`${DME_NAME}.dmb`, `${DME_NAME}.rsc`];
  },
  executes: async ({ get }) => {
    await DreamMaker(`${DME_NAME}.dme`, {
      defines: ["CBT", ...get(DefineParameter)],
      warningsAsErrors: get(WarningParameter).includes("error"),
      ignoreWarningCodes: get(NoWarningParameter),
      namedDmVersion: get(DmVersionParameter),
    });
  },
});

export const DmTestTarget = new Juke.Target({
  parameters: [
    DefineParameter,
    DmVersionParameter,
    WarningParameter,
    NoWarningParameter,
  ],
  dependsOn: ({ get }) => [
    get(DefineParameter).includes("ALL_MAPS") && DmMapsIncludeTarget,
  ],
  executes: async ({ get }) => {
    fs.copyFileSync(`${DME_NAME}.dme`, `${DME_NAME}.test.dme`);
    await DreamMaker(`${DME_NAME}.test.dme`, {
      defines: ["CBT", "CIBUILDING", ...get(DefineParameter)],
      warningsAsErrors: get(WarningParameter).includes("error"),
      ignoreWarningCodes: get(NoWarningParameter),
      namedDmVersion: get(DmVersionParameter),
    });
    Juke.rm("data/logs/ci", { recursive: true });
    const options = {
      dmbFile: `${DME_NAME}.test.dmb`,
      namedDmVersion: get(DmVersionParameter),
    };
    await DreamDaemon(
      options,
      "-close",
      "-trusted",
      "-verbose",
      "-params",
      "log-directory=ci"
    );
    Juke.rm("*.test.*");
    try {
      const cleanRun = fs.readFileSync("data/logs/ci/clean_run.lk", "utf-8");
      console.log(cleanRun);
    } catch (err) {
      Juke.logger.error("Test run was not clean, exiting");
      throw new Juke.ExitCode(1);
    }
  },
});

export const AutowikiTarget = new Juke.Target({
  parameters: [
    DefineParameter,
    DmVersionParameter,
    WarningParameter,
    NoWarningParameter,
  ],
  dependsOn: ({ get }) => [
    get(DefineParameter).includes("ALL_MAPS") && DmMapsIncludeTarget,
  ],
  outputs: ["data/autowiki_edits.txt"],
  executes: async ({ get }) => {
    fs.copyFileSync(`${DME_NAME}.dme`, `${DME_NAME}.test.dme`);
    await DreamMaker(`${DME_NAME}.test.dme`, {
      defines: ["CBT", "AUTOWIKI", ...get(DefineParameter)],
      warningsAsErrors: get(WarningParameter).includes("error"),
      ignoreWarningCodes: get(NoWarningParameter),
      namedDmVersion: get(DmVersionParameter),
    });
    Juke.rm("data/autowiki_edits.txt");
    Juke.rm("data/autowiki_files", { recursive: true });
    Juke.rm("data/logs/ci", { recursive: true });

    const options = {
      dmbFile: `${DME_NAME}.test.dmb`,
      namedDmVersion: get(DmVersionParameter),
    };
    await DreamDaemon(
      options,
      "-close",
      "-trusted",
      "-verbose",
      "-params",
      "log-directory=ci"
    );
    Juke.rm("*.test.*");
    if (!fs.existsSync("data/autowiki_edits.txt")) {
      Juke.logger.error("Autowiki did not generate an output, exiting");
      throw new Juke.ExitCode(1);
    }
  },
});

export const YarnTarget = new Juke.Target({
  parameters: [CiParameter],
  inputs: [
    "tgui/.yarn/+(cache|releases|plugins|sdks)/**/*",
    "tgui/**/package.json",
    "tgui/yarn.lock",
  ],
  outputs: ["tgui/.yarn/install-target"],
  executes: ({ get }) => yarn("install", get(CiParameter) && "--immutable"),
});

export const TgFontTarget = new Juke.Target({
  dependsOn: [YarnTarget],
  inputs: [
    "tgui/.yarn/install-target",
    "tgui/packages/tgfont/**/*.+(js|cjs|svg)",
    "tgui/packages/tgfont/package.json",
  ],
  outputs: [
    "tgui/packages/tgfont/dist/tgfont.css",
    "tgui/packages/tgfont/dist/tgfont.eot",
    "tgui/packages/tgfont/dist/tgfont.woff2",
  ],
  executes: async () => {
    await yarn("tgfont:build");
    fs.copyFileSync(
      "tgui/packages/tgfont/dist/tgfont.css",
      "tgui/packages/tgfont/static/tgfont.css"
    );
    fs.copyFileSync(
      "tgui/packages/tgfont/dist/tgfont.eot",
      "tgui/packages/tgfont/static/tgfont.eot"
    );
    fs.copyFileSync(
      "tgui/packages/tgfont/dist/tgfont.woff2",
      "tgui/packages/tgfont/static/tgfont.woff2"
    );
  },
});

export const TguiTarget = new Juke.Target({
  dependsOn: [YarnTarget],
  inputs: [
    "tgui/.yarn/install-target",
    "tgui/webpack.config.js",
    "tgui/**/package.json",
    "tgui/packages/**/*.+(js|cjs|ts|tsx|scss)",
  ],
  outputs: [
    "tgui/public/tgui.bundle.css",
    "tgui/public/tgui.bundle.js",
    "tgui/public/tgui-panel.bundle.css",
    "tgui/public/tgui-panel.bundle.js",
    "tgui/public/tgui-say.bundle.css",
    "tgui/public/tgui-say.bundle.js",
  ],
  executes: () => yarn("tgui:build"),
});

export const TguiEslintTarget = new Juke.Target({
  parameters: [CiParameter],
  dependsOn: [YarnTarget],
  executes: ({ get }) => yarn("tgui:lint", !get(CiParameter) && "--fix"),
});

export const TguiPrettierTarget = new Juke.Target({
  dependsOn: [YarnTarget],
  executes: () => yarn("tgui:prettier"),
});

export const TguiSonarTarget = new Juke.Target({
  dependsOn: [YarnTarget],
  executes: () => yarn("tgui:sonar"),
});

export const TguiTscTarget = new Juke.Target({
  dependsOn: [YarnTarget],
  executes: () => yarn("tgui:tsc"),
});

export const TguiTestTarget = new Juke.Target({
  parameters: [CiParameter],
  dependsOn: [YarnTarget],
  executes: ({ get }) =>
    yarn(`tgui:test-${get(CiParameter) ? "ci" : "simple"}`),
});

export const TguiLintTarget = new Juke.Target({
  dependsOn: [YarnTarget, TguiPrettierTarget, TguiEslintTarget, TguiTscTarget],
});

export const TguiDevTarget = new Juke.Target({
  dependsOn: [YarnTarget],
  executes: ({ args }) => yarn("tgui:dev", ...args),
});

export const TguiAnalyzeTarget = new Juke.Target({
  dependsOn: [YarnTarget],
  executes: () => yarn("tgui:analyze"),
});

export const TguiBenchTarget = new Juke.Target({
  dependsOn: [YarnTarget],
  executes: () => yarn("tgui:bench"),
});

export const TestTarget = new Juke.Target({
  dependsOn: [DmTestTarget, TguiTestTarget],
});

export const LintTarget = new Juke.Target({
  dependsOn: [TguiLintTarget],
});

export const BuildTarget = new Juke.Target({
  dependsOn: [TguiTarget, DmTarget],
});

export const ServerTarget = new Juke.Target({
  parameters: [DmVersionParameter, PortParameter],
  dependsOn: [BuildTarget],
  executes: async ({ get }) => {
    const port = get(PortParameter) || "1337";
    const options = {
      dmbFile: `${DME_NAME}.dmb`,
      namedDmVersion: get(DmVersionParameter),
    };
    await DreamDaemon(options, port, "-trusted");
  },
});

export const AllTarget = new Juke.Target({
  dependsOn: [TestTarget, LintTarget, BuildTarget],
});

export const TguiCleanTarget = new Juke.Target({
  executes: async () => {
    Juke.rm("tgui/public/.tmp", { recursive: true });
    Juke.rm("tgui/public/*.map");
    Juke.rm("tgui/public/*.{chunk,bundle,hot-update}.*");
    Juke.rm("tgui/packages/tgfont/dist", { recursive: true });
    Juke.rm("tgui/.yarn/{cache,unplugged,webpack}", { recursive: true });
    Juke.rm("tgui/.yarn/build-state.yml");
    Juke.rm("tgui/.yarn/install-state.gz");
    Juke.rm("tgui/.yarn/install-target");
    Juke.rm("tgui/.pnp.*");
  },
});

export const CleanTarget = new Juke.Target({
  dependsOn: [TguiCleanTarget],
  executes: async () => {
    Juke.rm("*.{dmb,rsc}");
    Juke.rm("*.mdme*");
    Juke.rm("*.m.*");
    Juke.rm("_maps/templates.dm");
  },
});

/**
 * Removes more junk at the expense of much slower initial builds.
 */
export const CleanAllTarget = new Juke.Target({
  dependsOn: [CleanTarget],
  executes: async () => {
    Juke.logger.info("Cleaning up data/logs");
    Juke.rm("data/logs", { recursive: true });
    Juke.logger.info("Cleaning up global yarn cache");
    await yarn("cache", "clean", "--all");
  },
});

/**
 * Prepends the defines to the .dme.
 * Does not clean them up, as this is intended for TGS which
 * clones new copies anyway.
 */
const prependDefines = (...defines) => {
  const dmeContents = fs.readFileSync(`${DME_NAME}.dme`);
  const textToWrite = defines.map((define) => `#define ${define}\n`).join("");
  fs.writeFileSync(`${DME_NAME}.dme`, `${textToWrite}\n${dmeContents}`);
};

export const TgsTarget = new Juke.Target({
  dependsOn: [TguiTarget],
  executes: async () => {
    Juke.logger.info("Prepending TGS & CBT define");
    prependDefines("TGS", "CBT");
  },
});

const TGS_MODE = process.env.CBT_BUILD_MODE === "TGS";

export default TGS_MODE ? TgsTarget : BuildTarget;
