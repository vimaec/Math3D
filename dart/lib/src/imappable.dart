part of '../vim_math3d.dart';

abstract class IMappable<TContainer, TPart> {
  TContainer map(TPart Function(TPart) f);
}
