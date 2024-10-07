class RegionState {
	final bool isLoading;
	final String? error;
	  
	const RegionState({
		this.isLoading = false,
		this.error,
	});
	  
	RegionState copyWith({
		bool? isLoading,
		String? error,
	}) {
		return RegionState(
			isLoading: isLoading ?? this.isLoading,
			error: error ?? this.error,
		);
	}
}
