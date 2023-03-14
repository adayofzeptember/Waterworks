part of 'done_bloc.dart';

// md
class DoneState extends Equatable {
  DoneState(
      {required this.written, required this.page, required this.isLoading});

  List written;
  int page;
  bool isLoading;

  DoneState copyWith({
    List? written,
    int? page,
    bool? isLoading,
  }) {
    return DoneState(
       written:  written ?? this. written,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [ written, page, isLoading];
}
