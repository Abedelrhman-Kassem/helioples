import 'package:flutter/material.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({super.key});

  @override
  _SpecialOffersState createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  int _quantity = 0;
  bool _isSoldOut = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Special Offers")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return ProductCard(
              quantity: _quantity,
              isSoldOut: _isSoldOut,
              onAdd: () {
                setState(() {
                  _quantity++;
                });
              },
              onRemove: () {
                setState(() {
                  if (_quantity > 0) _quantity--;
                });
              },
              onPillClick: () {
                setState(() {
                  _isSoldOut = !_isSoldOut; // Toggle sold out state
                });
              },
            );
          }),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final int quantity;
  final bool isSoldOut;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onPillClick;

  ProductCard({
    required this.quantity,
    required this.isSoldOut,
    required this.onAdd,
    required this.onRemove,
    required this.onPillClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image Placeholder
          Container(
            height: 100,
            width: 100,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 16),
          // Product Name Placeholder
          Text("Product Name"),
          SizedBox(height: 16),
          // Conditional Rendering of the Button or Pill
          quantity == 0 && !isSoldOut
              ? AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: onAdd,
                  ),
                )
              : isSoldOut
                  ? GestureDetector(
                      onTap: onPillClick,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.only(left: isSoldOut ? 0 : 10),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: isSoldOut ? Colors.red : Colors.grey,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isSoldOut ? 'Sold Out' : 'Buy',
                              style: TextStyle(color: Colors.white),
                            ),
                            if (!isSoldOut)
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.white, size: 12),
                              ),
                          ],
                        ),
                      ),
                    )
                  : AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Container(
                        key: ValueKey<int>(quantity),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: Colors.white),
                              onPressed: onRemove,
                            ),
                            Text(
                              '$quantity',
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: onAdd,
                            ),
                          ],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
