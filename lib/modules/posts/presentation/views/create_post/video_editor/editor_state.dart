import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class EditorState extends Equatable {}

class EditorInitial extends EditorState {
  final File file;
  EditorInitial(this.file);
  @override
  List<Object?> get props => [file];
}

class EditorTrimming extends EditorState {
  @override
  List<Object?> get props => [];
}

class EditorCropping extends EditorState {
  @override
  List<Object?> get props => [];
  
}

class EditorSaving extends EditorState {
  @override
  List<Object?> get props => [];
  
}
