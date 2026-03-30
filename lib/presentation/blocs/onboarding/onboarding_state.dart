class OnboardingState {
  final int currentPage;
  final int totalPages;
  final bool locationGranted;
  final bool isComplete;

  const OnboardingState({
    this.currentPage = 0,
    this.totalPages = 4,
    this.locationGranted = false,
    this.isComplete = false,
  });

  OnboardingState copyWith({
    int? currentPage,
    bool? locationGranted,
    bool? isComplete,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages,
      locationGranted: locationGranted ?? this.locationGranted,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
