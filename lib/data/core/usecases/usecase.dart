
import 'package:fpdart/fpdart.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Exception, Type>> call({required Params params});
}
