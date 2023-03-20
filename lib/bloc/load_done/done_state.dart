part of 'done_bloc.dart';

// md
class DoneState extends Equatable {
  DoneState({
    required this.written,
    required this.page,
    required this.isLoading,
    required this.stopLoad,
    required this.error,
    required this.segmentActive,
  });

  List written;
  int page;
  bool isLoading, stopLoad;
  String error;
  int segmentActive;

  DoneState copyWith({
    List? written,
    int? page,
    bool? isLoading,
    bool? stopLoad,
    String? error,
    int? segmentActive,
  }) {
    return DoneState(
      written: written ?? this.written,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      stopLoad: stopLoad ?? this.stopLoad,
      error: error ?? this.error,
      segmentActive: segmentActive ?? this.segmentActive,
    );
  }

  @override
  List<Object> get props => [
        written,
        page,
        isLoading,
        stopLoad,
        error,
        segmentActive,
      ];
}
