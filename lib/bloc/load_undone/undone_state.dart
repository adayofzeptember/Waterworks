part of 'undone_bloc.dart';

class NotWriteState extends Equatable {
  List notWrite;
  int page;
  bool isLoading;
  String error;
  int segmentActive;
  String filterId, hiddenMeter;

  NotWriteState({
    required this.notWrite,
    required this.page,
    required this.isLoading,
    required this.error,
    required this.segmentActive,
    required this.filterId,
    required this.hiddenMeter,
  });

  NotWriteState copyWith({
    List? notWrite,
    int? page,
    bool? isLoading,
    String? error,
    int? segmentActive,
    String? filterId,
    String? hiddenMeter,
  }) {
    return NotWriteState(
      notWrite: notWrite ?? this.notWrite,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      segmentActive: segmentActive ?? this.segmentActive,
      filterId: filterId ?? this.filterId,
      hiddenMeter: hiddenMeter ?? this.hiddenMeter,
    );
  }

  @override
  List<Object> get props => [
        notWrite,
        page,
        isLoading,
        error,
        segmentActive,
        filterId,
        hiddenMeter,
      ];
}
