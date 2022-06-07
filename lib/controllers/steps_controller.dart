/// This is to control the data you want to display step by step
class StepsController {
  late void Function() next;
  late void Function() previous;

  void addListener(
    void Function() next,
    void Function() previous,
  ) {
    this.next = next;
    this.previous = previous;
  }
}
