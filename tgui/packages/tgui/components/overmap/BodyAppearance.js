import { Graphics, Sprite, Matrix } from 'pixi.js';


// These must be kept in sync with the #DEFINEs in code/__DEFINES/overmap.dm
// If they fall out of sync, overmap bodies will break.
const OVERMAP_BODY_CIRCLE = "circle";
const OVERMAP_BODY_RECTANGLE = "rectangle";
const OVERMAP_BODY_SPRITE = "sprite";

const DUMMY_RADIUS = 25;

export function getUpdateAppearance(appearanceType) {
  switch (appearanceType) {
    case OVERMAP_BODY_CIRCLE:
      return CircleAppearance;
    case OVERMAP_BODY_RECTANGLE:
      return RectangleAppearance;
    case OVERMAP_BODY_SPRITE:
      return SpriteAppearance;
  }
}

// args.radius
// args.color
function CircleAppearance(container, args) {
  if (!container) {
    container = new Graphics();
  }
  container.clear();
  container.beginFill(args.color);

  // so, the shape drawn by drawCircle isn't actually a circle, it's a polygon
  // that looks like a circle. the number of sides in that polygon scales with
  // the radius. we can't use the body's "true" size directly, since it's a
  // really small number; the shape ends up with very few sides. it doesn't
  // look like a circle. instead, we draw a circle with a larger radius, and
  // use a matrix to scale down the drawing.
  const scaleMatrix = new Matrix(args.radius/DUMMY_RADIUS, 0, 0, args.radius/DUMMY_RADIUS);
  container.setMatrix(scaleMatrix);

  container.drawCircle(0, 0, DUMMY_RADIUS);
  container.endFill();

  return container;
}

// args.width
// args.height
// args.color
function RectangleAppearance(container, args) {
  if (!container) {
    container = new Graphics();
  }
  container.clear();
  container.beginFill(args.color);
  // drawRect draws from top left to bottom right, so we need to offset the starting location
  container.drawRect(-args.width/2, -args.height/2, args.width, args.height)
  container.endFill();

  return container;
}

//
//
function SpriteAppearance(container, args) {
  if (!container) {
    container = new Sprite();
  }

  return container;
}
