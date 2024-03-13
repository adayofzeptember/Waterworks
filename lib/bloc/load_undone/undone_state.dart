// ignore_for_file: must_be_immutable

part of 'undone_bloc.dart';

class NotWriteState extends Equatable {
  List notWrite;
  int page;
  bool isLoading;
  String error;
  int segmentActive;
  String filterId, hiddenMeter;
  int dataTotal;

  NotWriteState({
    required this.notWrite,
    required this.page,
    required this.isLoading,
    required this.error,
    required this.segmentActive,
    required this.filterId,
    required this.hiddenMeter,
    required this.dataTotal,
  });

  NotWriteState copyWith({
    List? notWrite,
    int? page,
    bool? isLoading,
    String? error,
    int? segmentActive,
    String? filterId,
    String? hiddenMeter,
    int? dataTotal,
  }) {
    return NotWriteState(
      notWrite: notWrite ?? this.notWrite,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      segmentActive: segmentActive ?? this.segmentActive,
      filterId: filterId ?? this.filterId,
      hiddenMeter: hiddenMeter ?? this.hiddenMeter,
      dataTotal: dataTotal ?? this.dataTotal,
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
        dataTotal,
      ];
}
