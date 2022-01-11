export const EventSystem = new EventSystem();

// TODO: cleanup
class EventSystem extends EventTarget {
  raiseEvent(eventType, ...args) {
    const event = new eventType(...args);
    return this.dispatchEvent(event);
  }

  subscribe(eventType, func) {
    return this.addEventListener(eventType.eventID(), func, false);
  }

  unsubscribe(eventType, func) {
    return this.removeEventListener(eventType.eventID(), func, false);
  }
}
