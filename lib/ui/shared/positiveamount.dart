positiveAmount(double inputAmount) {
  if (inputAmount < 0) {
    return inputAmount.toString().substring(1, inputAmount.toString().length);
  } else {
    return inputAmount.toString();
  }
}
