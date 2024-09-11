import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_id_03/core/style/sytle.dart';
import 'package:task_id_03/feature/shopping/controller/shopping_cubit.dart';
import 'package:task_id_03/feature/shopping/presentation/screens/widgets/custom_painter.dart';

class ShoppingListPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 250, // Adjust this as needed
            child: Stack(
              children: [
                CustomPaint(
                  size: const Size(
                      double.infinity, 250), // Ensure CustomPaint has size
                  painter: WavePainter(),
                ),
                Positioned(
                  top: 30,
                  left: 16,
                  right: 16,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text('Shopping List', style: appbarStyle),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Enter a new item',
                            hintStyle: bodyStyle,
                            filled: true,
                            fillColor: Colors.red.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 10),
                      // Add button with animation
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              context
                                  .read<ShoppingCubit>()
                                  .addItem(_controller.text);
                              _controller.clear();
                              _listKey.currentState?.insertItem(0);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Expanded for the list of items
                  Expanded(
                    child: BlocBuilder<ShoppingCubit, List<String>>(
                      builder: (context, shoppingList) {
                        return AnimatedList(
                          key: _listKey,
                          initialItemCount: shoppingList.length,
                          itemBuilder: (context, index, animation) {
                            final item = shoppingList[index];
                            return _buildItem(item, animation, index, context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String item, Animation<double> animation, int index,
      BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Dismissible(
        key: Key(item),
        onDismissed: (direction) {
          context.read<ShoppingCubit>().removeItem(index);
          _listKey.currentState
              ?.removeItem(index, (context, animation) => SizedBox());
        },
        background: Container(color: Colors.redAccent),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: ListTile(
            title: Text(item, style: TextStyle(fontSize: 18)),
            trailing: Icon(
              Icons.shopping_cart,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
