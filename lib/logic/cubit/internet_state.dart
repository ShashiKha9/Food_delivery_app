part of 'internet_cubit.dart';


abstract class InternetState extends Equatable {
  const InternetState();
}

class InternetLoading extends InternetState {
  @override
  List<Object> get props => [];
}
class InternetConnected extends InternetState{
final   Internet internet;

InternetConnected({required this.internet});
  @override
  List<Object?> get props => throw UnimplementedError();

}
class InternetDisconnected extends  InternetState{
  @override
  List<Object?> get props => throw UnimplementedError();

}
