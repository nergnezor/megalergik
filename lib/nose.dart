import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

List<Nose> createNose(Forge2DGame game, {double? strokeWidth}) {
  final visibleRect = game.camera.visibleWorldRect;
  // final topLeft = visibleRect.topLeft.toVector2();
  final topLeft = Vector2(visibleRect.left, -100);
  // final topRight = visibleRect.topRight.toVector2();
  final topRight = Vector2(visibleRect.right, -100);
  final bottomRight = visibleRect.bottomRight.toVector2();
  final bottomLeft = visibleRect.bottomLeft.toVector2();

  return [
    // Wall(topLeft, topRight, strokeWidth: strokeWidth),
    Nose(topRight, bottomRight, strokeWidth: strokeWidth),
    // Wall(bottomLeft, bottomRight, strokeWidth: strokeWidth),
    Nose(topLeft, bottomLeft, strokeWidth: strokeWidth),
  ];
}

class Nose extends BodyComponent {
  final Vector2 start;
  final Vector2 end;
  final double strokeWidth;

  Nose(this.start, this.end, {double? strokeWidth})
      : strokeWidth = strokeWidth ?? 0.1;

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: Vector2.zero(),
    );
    paint.strokeWidth = strokeWidth;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}