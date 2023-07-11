part of 'profile_bloc.dart';
// ignore_for_file: must_be_immutable
class ProfileState extends Equatable {
  String name;
  List segs, idSegs;

  ProfileState({required this.name, required this.segs, required this.idSegs});

  ProfileState copyWith({
    String? name,
    List? segs,
    List? idSegs,
  }) {
    return ProfileState(
      name: name ?? this.name,
      segs: segs ?? this.segs,
      idSegs: idSegs ?? this.idSegs,
    );
  }

  @override
  List<Object> get props => [name, segs, idSegs];
}

//class ProfileInitial extends ProfileState {}
