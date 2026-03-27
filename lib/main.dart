import 'package:flutter/material.dart';
import 'product.dart';

void main() => runApp(const DulceAromaApp());

// Color global para evitar errores de tipo 'Null'
const Color kPrimaryPink = Color(0xFFFF4B8B);

class DulceAromaApp extends StatelessWidget {
  const DulceAromaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: kPrimaryPink),
      home: const StorePage(),
    );
  }
}

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const Icon(Icons.menu, color: kPrimaryPink), // Menu en rosado
        title: const Text(
          'Dulce Aroma',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: kPrimaryPink,
            ), // Bolsa en rosado
          ),
        ],
      ),
      body: Column(
        children: [
          const CategoryTabs(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const MorningSpecialBanner(),
                  const SizedBox(height: 24),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 0.68,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: const [
                      ProductCard(
                        name: 'Sourdough Loaf',
                        price: '8.50',
                        tag: 'ARTISANAL BREAD',
                        imageUrl:
                            'https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=500',
                      ),
                      ProductCard(
                        name: 'Chocolate Fudge',
                        price: '35.00',
                        tag: 'DECORATED CAKE',
                        imageUrl:
                            'https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=500',
                      ),
                      ProductCard(
                        name: 'French Croissant',
                        price: '4.25',
                        tag: 'CLASSIC PASTRY',
                        imageUrl:
                            'https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=500',
                      ),
                      ProductCard(
                        name: 'Strawberry Tart',
                        price: '6.50',
                        tag: 'FRESH FRUIT',
                        imageUrl:
                            'https://images.unsplash.com/photo-1519915028121-7d3463d20b13?q=80&w=500',
                      ),
                      // NUEVOS PRODUCTOS AGREGADOS
                      ProductCard(
                        name: 'Macaron Box',
                        price: '12.00',
                        tag: 'SWEET TREATS',
                        imageUrl:
                            'https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=500',
                      ),
                      ProductCard(
                        name: 'Choco Cookies',
                        price: '3.75',
                        tag: 'FRESH BAKED',
                        imageUrl:
                            'https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=500',
                      ),
                    ],
                  ),
                  const SizedBox(height: 100), // Espacio para el botón flotante
                ],
              ),
            ),
          ),
        ],
      ),
      // --- BOTÓN FLOTANTE DEL CARRITO REINTEGRADO ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryPink,
        shape: const CircleBorder(),
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    final items = [
      {'icon': Icons.storefront_outlined, 'label': 'SHOP'},
      {'icon': Icons.search, 'label': 'SEARCH'},
      {'icon': Icons.assignment_outlined, 'label': 'ORDERS'},
      {'icon': Icons.person_outline, 'label': 'PROFILE'},
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = index == _selectedNavIndex;
          return GestureDetector(
            onTap: () => setState(() => _selectedNavIndex = index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  items[index]['icon'] as IconData,
                  color: isSelected ? kPrimaryPink : Colors.grey.shade400,
                  size: 22,
                ),
                const SizedBox(height: 3),
                Text(
                  items[index]['label'] as String,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: isSelected
                        ? FontWeight.w700
                        : FontWeight.normal,
                    color: isSelected ? kPrimaryPink : Colors.grey.shade400,
                    letterSpacing: 0.5,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 3),
                  width: 18,
                  height: 3,
                  decoration: BoxDecoration(
                    color: isSelected ? kPrimaryPink : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name, price, tag, imageUrl;
  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.tag,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductDetailPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      color: kPrimaryPink,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tag,
                    style: const TextStyle(color: Colors.grey, fontSize: 9),
                  ),
                ],
              ),
            ),
            // Botón "+" circular en cada card
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(right: 8, bottom: 8),
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: kPrimaryPink,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Breads',
            style: TextStyle(color: kPrimaryPink, fontWeight: FontWeight.bold),
          ),
          Text('Cakes', style: TextStyle(color: Colors.grey)),
          Text('Pastries', style: TextStyle(color: Colors.grey)),
          Text('Coffee', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class MorningSpecialBanner extends StatelessWidget {
  const MorningSpecialBanner({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6A9A), kPrimaryPink],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Morning Specials',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Fresh from the oven every 6:00 AM',
            style: TextStyle(color: Colors.white, fontSize: 11),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '20% OFF TODAY',
              style: TextStyle(
                color: kPrimaryPink,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}