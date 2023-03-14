part of 'undone_bloc.dart';

class NotWriteState extends Equatable {
  
  NotWriteState({
    required this.notWrite,
    required this.page,
    required this.isLoading,
  });
  List notWrite;
  int page;
  bool isLoading;

  NotWriteState copyWith({
    List? notWrite,
    int? page,
    bool? isLoading,
  }) {
    return NotWriteState(
      notWrite: notWrite ?? this.notWrite,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        notWrite,
        page,
        isLoading,
      ];
}
