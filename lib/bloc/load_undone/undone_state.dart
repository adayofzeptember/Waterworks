part of 'undone_bloc.dart';

class NotWriteState extends Equatable {
  List notWrite;
  int page;
  bool isLoading, stopLoad;
  String error;
  int segmentActive;

  NotWriteState({
    required this.notWrite,
    required this.page,
    required this.isLoading,
    required this.error,
    required this.segmentActive,
    required this.stopLoad,
  });

  NotWriteState copyWith({
    List? notWrite,
    int? page,
    bool? isLoading,
    String? error,
    int? segmentActive,
    bool? stopLoad,
  }) {
    return NotWriteState(
      notWrite: notWrite ?? this.notWrite,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      segmentActive: segmentActive ?? this.segmentActive,
      stopLoad: stopLoad ?? this.stopLoad,
    );
  }

  @override
  List<Object> get props => [notWrite, page, isLoading, error, segmentActive, stopLoad];
}
