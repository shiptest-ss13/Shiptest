
// TODO: maybe sidestep CustomEvent entirely? could be useful w/ typescript
class BaseEvent extends CustomEvent {
  static eventID()

  constructor(detailVal) {
    return super(eventID(), { detail: detailVal } );
  }
}

export class RunTickEvent extends BaseEvent {
  static eventID() { return 'runtick'; }

  constructor(deltaT) {
    return super(deltaT);
  }
}

export class ChangeZoomEvent extends BaseEvent {
  static eventID() { return 'changezoom'; }

  constructor(zoomLevel) {
    return super(zoomLevel);
  }
}

export class ChangeClickEvent extends BaseEvent {
  static eventID() { return 'changeclick'; }

  constructor(onClick) {
    return super(onClick);
  }
}
