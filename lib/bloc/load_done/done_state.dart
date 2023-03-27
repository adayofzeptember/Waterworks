part of 'done_bloc.dart';

// md
class DoneState extends Equatable {
  DoneState({
    required this.written,
    required this.page,
    required this.isLoading,
    required this.error,
    required this.segmentActive,
    required this.filterId,
  });

  List written;
  int page;
  bool isLoading;
  String error;
  int segmentActive;
  String filterId;
  DoneState copyWith({
    List? written,
    int? page,
    bool? isLoading,
    String? error,
    int? segmentActive,
    String? filterId,
  }) {
    return DoneState(
      written: written ?? this.written,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      segmentActive: segmentActive ?? this.segmentActive,
      filterId: filterId ?? this.filterId,
    );
  }

  @override
  List<Object> get props => [
        written,
        page,
        isLoading,
        error,
        segmentActive,
        filterId,
      ];
}
