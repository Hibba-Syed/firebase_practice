import 'package:flutter/material.dart';
class IncrementWidget extends StatefulWidget {
  final int initialVale;
  final int min;
  final int max;
  final int step;
  final Function(int) onChanged;
   const IncrementWidget({
     super.key,
     required this.initialVale,
     required this.min,
     required this.max,
     required this.step,
     required this.onChanged,
});

  @override
  State<IncrementWidget> createState() => _IncrementWidgetState();
}

class _IncrementWidgetState extends State<IncrementWidget> {
  int currentValue = 0;
  @override
  void initState() {

    super.initState();
    currentValue = widget.initialVale;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: (){
              setState(() {
                if(currentValue > widget.min){
                  currentValue -= widget.step;
                }
                widget.onChanged(currentValue);
              });
            },
            icon: const Icon(Icons.remove_circle,color: Colors.green,)
        ),
        Text(currentValue.toString(),
          style: const TextStyle(
            fontSize: 30
          ),),
        IconButton(
            onPressed: (){
              setState(() {
                if(currentValue < widget.max){
                  currentValue += widget.step;
                }
                widget.onChanged(currentValue);
              });
            },
            icon: const Icon(Icons.add_circle,color: Colors.green,)
        ),
      ],
    );
  }
}
