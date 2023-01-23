
import 'dart:collection';

import 'package:flame/components.dart';

import '../../utils/enums/direction_enum.dart';
import '../component/cell.dart';
import 'snake_body_part.dart';

class Snake {

  final LinkedList<SnakeBodyPart> snakeBody = LinkedList();

  SnakeEvent direction = SnakeEvent.right;
  Cell head = Cell.zero;

  void move(Cell nextCell) {
    _removeLast();
    head = nextCell;
    _addFirst(head);
  }

  void grow(Cell nextCell) {
    head = nextCell;
    _addFirst(head);
  }

  bool checkCrash(Cell nextCell) {
    for (var part in snakeBody) {
      if (part.cell == nextCell) {
        return true;
      }
    }

    return false;
  }

  void setHead(Cell cell) {
    head = cell;
  }

  bool isHorizontal() {
    return direction == SnakeEvent.left || direction == SnakeEvent.right;
  }

  Vector2 displacementToHead(Vector2 reference) {
    return reference - head.location;
  }

  void addCell(Cell cell) {
    _add(SnakeBodyPart.fromCell(cell));
  }

  void _add(SnakeBodyPart part) {
    snakeBody.add(part);
  }

  void _addFirst(Cell cell) {
    snakeBody.addFirst(SnakeBodyPart.fromCell(cell));
  }

  void _removeLast() {
    snakeBody.last.cell.cellType = CellType.empty;
    snakeBody.remove(snakeBody.last);
  }
}