import 'package:flutter/material.dart';
import 'package:jibbab_app/discount_register_screen.dart';

// 🌟 앱 전체에서 공유할 전역 할인정보 데이터 리스트
// 새로 등록한 데이터가 유지되도록 클래스 바깥으로 빼냈습니다.
List<Map<String, dynamic>> globalDiscounts = [
  {'mart': '이마트', 'item': '신선 특란 30구', 'discount': '30% 할인', 'originalPrice': '8,900원', 'salePrice': '6,230원', 'expiry': '~ 4/30까지', 'author': '세아님', 'time': '10분 전', 'likes': 12, 'color': Colors.blue},
  {'mart': '홈플러스', 'item': '한우 1등급 등심 100g', 'discount': '50% 할인', 'originalPrice': '12,000원', 'salePrice': '6,000원', 'expiry': '~ 5/2까지', 'author': '고기러버', 'time': '32분 전', 'likes': 45, 'color': Colors.red},
  {'mart': '쿠팡', 'item': '곰곰 국산 무농약 콩나물', 'discount': '15% 할인', 'originalPrice': '1,500원', 'salePrice': '1,270원', 'expiry': '재고 소진 시', 'author': '자취마스터', 'time': '1시간 전', 'likes': 8, 'color': Colors.cyan},
  {'mart': '편의점', 'item': '햇반 210g 1+1 이벤트', 'discount': '50% 할인', 'originalPrice': '4,200원', 'salePrice': '2,100원', 'expiry': '~ 4/30까지', 'author': '편의점덕후', 'time': '2시간 전', 'likes': 23, 'color': Colors.deepPurple},
];

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({super.key});

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  String _selectedFilter = '전체';
  final List<String> _filters = ['전체', '이마트', '홈플러스', '쿠팡', '편의점'];

  // 🌟 등록 화면으로 이동하고, 완료되면 목록을 새로고침하는 함수
  Future<void> _navigateAndRefresh() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DiscountRegisterScreen()),
    );

    // 등록 화면에서 'true'를 돌려주면 새로고침 및 스낵바 띄우기
    if (result == true) {
      setState(() {}); // 화면 다시 그리기
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('할인정보가 등록됐어요! 🎉'),
            backgroundColor: Color(0xFF1D9E75),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1D9E75);

    // 필터링 로직: 선택된 마트만 보여주기
    final filteredDiscounts = _selectedFilter == '전체'
        ? globalDiscounts
        : globalDiscounts.where((d) => d['mart'].toString().contains(_selectedFilter)).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('할인정보', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: _navigateAndRefresh, // 👈 클릭 시 등록 화면으로
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _filters.map((filter) {
                final bool isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (val) => setState(() => _selectedFilter = filter),
                    selectedColor: primaryColor,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF5F5F5)),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredDiscounts.length,
              itemBuilder: (context, index) {
                return _buildDiscountCard(filteredDiscounts[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndRefresh, // 👈 클릭 시 등록 화면으로
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDiscountCard(Map<String, dynamic> d) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: (d['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Text(d['mart'], style: TextStyle(color: d['color'], fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Text('${d['author']} · ${d['time']}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Text(d['item'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(d['discount'], style: const TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(d['originalPrice'], style: const TextStyle(color: Colors.grey, fontSize: 13, decoration: TextDecoration.lineThrough)),
                  Text(d['salePrice'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [const Icon(Icons.access_time, size: 14, color: Colors.grey), const SizedBox(width: 4), Text(d['expiry'], style: const TextStyle(color: Colors.grey, fontSize: 13))]),
              Row(children: [const Icon(Icons.favorite_outline, size: 16, color: Colors.grey), const SizedBox(width: 4), Text('${d['likes']}', style: const TextStyle(color: Colors.grey))]),
            ],
          ),
        ],
      ),
    );
  }
}