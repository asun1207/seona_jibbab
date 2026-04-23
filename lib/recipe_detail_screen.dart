import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  // 상태 관리: 좋아요 개수와 클릭 여부
  int _likesCount = 1250;
  bool _isLiked = false;

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _isLiked ? _likesCount++ : _likesCount--;
    });
  }

  // 임시 데이터
  final List<Map<String, String>> _ingredients = [
    {'name': '밥', 'amount': '1공기'},
    {'name': '계란', 'amount': '1~2개'},
    {'name': '진간장', 'amount': '1큰술'},
    {'name': '참기름', 'amount': '1큰술'},
    {'name': '대파', 'amount': '약간'},
  ];

  final List<String> _steps = [
    '대파를 얇게 송송 썰어 준비합니다.',
    '프라이팬에 기름을 두르고 계란 프라이를 취향껏(반숙 추천) 굽습니다.',
    '따뜻한 밥 위에 계란 프라이와 썰어둔 대파를 올립니다.',
    '진간장 1큰술과 참기름 1큰술을 두르고 맛있게 비벼줍니다! (버터나 마가린을 추가하면 더 맛있어요)',
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1D9E75);

    return Scaffold(
      backgroundColor: Colors.white,
      // 1. 상단 앱바
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '간장계란밥',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {
              // 공유 기능 (나중에 구현)
            },
          ),
        ],
      ),
      // 메인 스크롤 영역
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2. 헤더 영역 (이모지, 제목, 뱃지)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('🍳', style: TextStyle(fontSize: 60)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '초간단 간장계란밥',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildBadge('한식', Colors.grey.shade600, Colors.grey.shade100),
                        const SizedBox(width: 8),
                        _buildBadge('간단', primaryColor, primaryColor.withOpacity(0.1)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Divider(color: Color(0xFFEEEEEE), thickness: 8),

            // 3. 요약 정보 행
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryItem(Icons.timer_outlined, '5분'),
                  _buildSummaryItem(Icons.kitchen_outlined, '재료 5개'),
                  GestureDetector(
                    onTap: _toggleLike,
                    child: _buildSummaryItem(
                      _isLiked ? Icons.favorite : Icons.favorite_outline,
                      '$_likesCount명',
                      iconColor: _isLiked ? Colors.red : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(color: Color(0xFFEEEEEE), thickness: 8),

            // 4. 재료 목록 섹션 (배달앱 메뉴판 스타일)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '재료 목록',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF3DE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: _ingredients.map((ingredient) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ingredient['name']!,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                ingredient['amount']!,
                                style: const TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // 5. 조리 순서 섹션
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '조리 순서',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(_steps.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: primaryColor,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              _steps[index],
                              style: const TextStyle(fontSize: 16, height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 40), // 하단 버튼을 위한 여백
                ],
              ),
            ),
          ],
        ),
      ),
      // 6. 하단 고정 버튼 (배달앱 '주문하기' 패러디)
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('오늘도 화이팅! 맛있게 해드세요 🍳')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              '지금 만들기 🍳',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  // 배지 위젯
  Widget _buildBadge(String text, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 요약 아이템 위젯
  Widget _buildSummaryItem(IconData icon, String text, {Color? iconColor}) {
    return Column(
      children: [
        Icon(icon, color: iconColor ?? Colors.grey.shade700, size: 28),
        const SizedBox(height: 8),
        Text(text, style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.bold)),
      ],
    );
  }
}