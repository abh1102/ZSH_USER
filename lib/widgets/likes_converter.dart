String formatLikesCount(int count) {
  if ( count < 0 || count == 0) {
    return '0';
  } else if (count < 1000) {
    return count.toString();
  } else if (count < 1000000) {
    double kCount = count / 1000;
    return '${kCount.toStringAsFixed(kCount.truncateToDouble() == kCount ? 0 : 1)}k';
  } else {
    double mCount = count / 1000000;
    return '${mCount.toStringAsFixed(mCount.truncateToDouble() == mCount ? 0 : 1)}m';
  }
}
