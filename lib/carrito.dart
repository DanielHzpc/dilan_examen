import 'package:flutter/material.dart';

class _Item {
  final String name, subtitle;
  final double price;
  final String image; // <-- ¡Cambiamos IconData por String!
  int qty;
  _Item(this.name, this.subtitle, this.price, this.image, this.qty);
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const _pink = Color(0xFFFF4D7E);
  static const _pinkBg = Color(0xFFFFF0F4);

  int _nav = 2;
  final _promo = TextEditingController();

  // <-- Aquí actualizamos la lista para usar URLs de imágenes
  final _items = [
    _Item(
      'Tun tun tun sahur',
      'Brainrot',
      8.50,
      'https://pbs.twimg.com/media/GvypgVWXQAECWFc.jpg',
      1,
    ),
    _Item(
      'Frigo Camelo',
      'Brainrot',
      4.25,
      'https://upload.wikimedia.org/wikipedia/commons/f/ff/Frigo_Camelo.png',
      2,
    ),
    _Item(
      'Bombardiro Crocodilo',
      'Brainrot',
      3.50,
      'https://media.printables.com/media/prints/1224224/images/9178270_c3f5024a-ea2c-4655-a0fb-f4e0bf256783_10cf6be6-8ee2-43dd-b95e-82514e0f301c/thumbs/cover/800x800/jpeg/img_4257.jpg',
      1,
    ),
  ];

  double get _subtotal => _items.fold(0, (s, i) => s + i.price * i.qty);
  double get _total => _subtotal + 2.99 - 2.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // MODIFICACIÓN AQUÍ:
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 22),
          onPressed: () {
            Navigator.pop(context); // Esto te devuelve a la pantalla anterior
          },
        ),
        centerTitle: true,
        title: const Text(
          'Dulce Aroma',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: _pinkBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.delete, color: _pink, size: 18),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Shopping Cart',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: _pinkBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_items.length} Items',
                          style: const TextStyle(
                            color: _pink,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ..._items.asMap().entries.map((e) => _card(e.value, e.key)),
                  const SizedBox(height: 12),
                  // Promo
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _promo,
                            style: const TextStyle(fontSize: 13),
                            decoration: InputDecoration(
                              hintText: 'Promo code',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: _pink,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Summary card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _row('Subtotal', '\$${_subtotal.toStringAsFixed(2)}'),
                        const SizedBox(height: 8),
                        _row('Delivery Fee', '\$2.99'),
                        const SizedBox(height: 8),
                        _row('Discount', '-\$2.00', vc: _pink),
                        const Divider(
                          height: 24,
                          thickness: 1,
                          color: Color(0xFFF0F0F0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '\$${_total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: _pink,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Checkout
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ),
          // Bottom nav
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  [
                    [Icons.storefront_outlined, 'SHOP'],
                    [Icons.search, 'SEARCH'],
                    [Icons.shopping_cart_outlined, 'CART'],
                    [Icons.person_outline, 'PROFILE'],
                  ].asMap().entries.map((e) {
                    final sel = e.key == _nav;
                    return GestureDetector(
                      onTap: () => setState(() => _nav = e.key),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            e.value[0] as IconData,
                            color: sel ? _pink : Colors.grey.shade400,
                            size: 22,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            e.value[1] as String,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: sel
                                  ? FontWeight.w700
                                  : FontWeight.normal,
                              color: sel ? _pink : Colors.grey.shade400,
                              letterSpacing: 0.5,
                            ),
                          ),
                          if (sel)
                            Container(
                              margin: const EdgeInsets.only(top: 3),
                              width: 18,
                              height: 3,
                              decoration: BoxDecoration(
                                color: _pink,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(_Item item, int i) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.07),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 65,
            height: 65,
            color: const Color(0xFFF2EDE8),
            // <-- ¡Aquí reemplazamos el Icon por el Image.network!
            child: Image.network(
              item.image,
              fit: BoxFit
                  .cover, // Esto asegura que la imagen llene el cuadrito sin deformarse
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Text(
                item.subtitle,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${item.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: _pink,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  if (item.qty > 1) item.qty--;
                }),
                child: Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.remove,
                    size: 13,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(width: 1, height: 28, color: Colors.grey.shade300),
              SizedBox(
                width: 28,
                height: 28,
                child: Center(
                  child: Text(
                    '${item.qty}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              Container(width: 1, height: 28, color: Colors.grey.shade300),
              GestureDetector(
                onTap: () => setState(() => item.qty++),
                child: Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  child: const Icon(Icons.add, size: 13, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _row(String label, String val, {Color? vc}) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
      Text(
        val,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: vc ?? Colors.black87,
        ),
      ),
    ],
  );
}
