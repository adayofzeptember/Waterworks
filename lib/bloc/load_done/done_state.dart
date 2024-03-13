// ignore_for_file: must_be_immutable

part of 'done_bloc.dart';

// md
class DoneState extends Equatable {
  List written;
  int page;
  bool isLoading;
  String error;
  int segmentActive;
  String filterId;
  int dataTotal;

  DoneState({
    required this.written,
    required this.page,
    required this.isLoading,
    required this.error,
    required this.segmentActive,
    required this.filterId,
    required this.dataTotal,
  });

  DoneState copyWith({
    List? written,
    int? page,
    bool? isLoading,
    String? error,
    int? segmentActive,
    String? filterId,
    int? dataTotal,
  }) {
    return DoneState(
      written: written ?? this.written,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      segmentActive: segmentActive ?? this.segmentActive,
      filterId: filterId ?? this.filterId,
      dataTotal: dataTotal ?? this.dataTotal,
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
        dataTotal,
      ];
}
