class AnggotaState {
	final bool isLoading;
	final String? error;
	  
	const AnggotaState({
		this.isLoading = false,
		this.error,
	});
	  
	AnggotaState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return AnggotaState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
