import 'package:flutter/material.dart';
import 'main.dart';
import 'carrito.dart'; // 👈 IMPORTANTE

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductDetailPage(),
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  String selectedPortion = "4-6";
  bool extraStrawberry = false;
  bool chocolate = false;

  final Color primary = const Color(0xFFE91E63);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        centerTitle: true,

        // 🔙 Volver a main.dart
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const StorePage()),
            );
          },
        ),

        title: const Text(
          "Product Detail",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.share, color: Colors.black),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🖼 Imagen
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://pbs.twimg.com/media/GvypgVWXQAECWFc?format=jpg&name=small",
                      height: 280,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 📝 Título + corazón rojo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "TUN TUN SAHUR",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.favorite_border,
                          size: 18,
                          color: primary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "TUN TUN SAHUR",
                    style: TextStyle(
                      color: primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "\$24.99",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  const Divider(color: Color(0xFFEAEAEA), thickness: 1),

                  const SizedBox(height: 10),

                  const Text(
                    "Tung Tung Sahur es un fenómeno viral de internet...",
                    style: TextStyle(color: Colors.grey, height: 1.4),
                  ),

                  const SizedBox(height: 10),

                  const Divider(color: Color(0xFFEAEAEA), thickness: 1),

                  const SizedBox(height: 20),

                  const Text(
                    "Select brainrot",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      _portion("4-6"),
                      const SizedBox(width: 10),
                      _portion("8-10"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Extra Toppings",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  _toppingRow(
                    title: "Extra brainrots",
                    price: "+\$3.00",
                    value: extraStrawberry,
                    onChanged: (v) {
                      setState(() => extraStrawberry = v);
                    },
                  ),

                  _toppingRow(
                    title: "brainrot Drizzle",
                    price: "+\$2.00",
                    value: chocolate,
                    onChanged: (v) {
                      setState(() => chocolate = v);
                    },
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // 🔻 Barra inferior
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Row(
              children: [
                // 🔢 Stepper
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                          }
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(quantity.toString()),
                      IconButton(
                        onPressed: () {
                          setState(() => quantity++);
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // 🛒 BOTÓN FUNCIONANDO
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(), // 👈 AQUÍ VA
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                    label: const Text("Add to Cart"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _portion(String value) {
    final selected = selectedPortion == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedPortion = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: selected ? primary.withOpacity(0.1) : Colors.white,
            border: Border.all(color: selected ? primary : Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              "$value brainrot",
              style: TextStyle(color: selected ? primary : Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget _toppingRow({
    required String title,
    required String price,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Checkbox(value: value, onChanged: (v) => onChanged(v!)),
          Expanded(child: Text(title)),
          Text(price),
        ],
      ),
    );
  }
}
