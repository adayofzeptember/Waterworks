part of 'undone_bloc.dart';

class NotWriteState extends Equatable {
  List notWrite;
  int page;
  bool isLoading, stopLoad;
  String error;
  int segmentActive;
  String filterId, hiddenMeter;

  NotWriteState({
    required this.notWrite,
    required this.page,
    required this.isLoading,
    required this.error,
    required this.segmentActive,
    required this.stopLoad,
    required this.filterId,
    required this.hiddenMeter,
  });

  NotWriteState copyWith({
    List? notWrite,
    int? page,
    bool? isLoading,
    String? error,
    int? segmentActive,
    bool? stopLoad,
    String? filterId,
    String? hiddenMeter,
  }) {
    return NotWriteState(
      notWrite: notWrite ?? this.notWrite,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      segmentActive: segmentActive ?? this.segmentActive,
      stopLoad: stopLoad ?? this.stopLoad,
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
        stopLoad,
        filterId,
        hiddenMeter,
      ];
}
