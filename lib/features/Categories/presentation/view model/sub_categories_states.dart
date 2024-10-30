import 'package:equatable/equatable.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';


abstract class FetchSubCatigoriesState extends Equatable
{
  const FetchSubCatigoriesState() ; 
   @override
  List<Object> get props => [];
}

class FetchSubCatigoriesInitial extends FetchSubCatigoriesState {}

class FetchSubCatigoriesLoading extends FetchSubCatigoriesState {}

class FetchSubCatigoriesSuccess extends FetchSubCatigoriesState{
    final List<SubCategories> subCategories ; 
    const FetchSubCatigoriesSuccess(this.subCategories);

}

class FetchSubCatigoriesFailure extends FetchSubCatigoriesState {
  final String msg ; 
  const FetchSubCatigoriesFailure(this.msg) ; 

  
}