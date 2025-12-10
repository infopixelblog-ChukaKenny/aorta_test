import 'package:equatable/equatable.dart';

abstract class BaseBlocState extends Equatable {
  final bool noNetworkError;
  final bool poorNetworkError;

  const BaseBlocState({
    this.noNetworkError = false,
    this.poorNetworkError = false,
  });

  List<Object> get baseProps {
    return [noNetworkError, poorNetworkError];
  }

}
