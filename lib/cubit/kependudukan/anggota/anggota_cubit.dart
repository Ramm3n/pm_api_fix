import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_pendataan_kewilayahan/cubit/kependudukan/anggota/anggota_state.dart';

class AnggotaCubit extends Cubit<AnggotaState> {
	AnggotaCubit() : super(AnggotaState(isLoading: true));
	
	Future<void> loadInitialData() async {
		final stableState = state;
		try {
		  emit(state.copyWith(isLoading: true));
	
		  // TODO your code here
	
		  emit(state.copyWith(isLoading: false));
		} catch (error) {
		  emit(state.copyWith(error: error.toString()));
		  emit(stableState.copyWith(isLoading: false));
		}
	}
}
