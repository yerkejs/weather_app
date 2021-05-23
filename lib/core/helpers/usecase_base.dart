import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_yerke/core/exceptions/exceptions_base.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class VoidUseCase<Params> {
  Future<void> call(Params params);
}

abstract class SuccessOnlyUseCase <Type, Params> {
  Future<Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}