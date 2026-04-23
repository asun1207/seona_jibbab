class Recipe {
  final String name;
  final String emoji;
  final String category;
  final String difficulty;
  final int ingredientCount;
  final String time;
  final int likes;
  final List<Map<String, String>> ingredients;
  final List<String> steps;

  Recipe({
    required this.name,
    required this.emoji,
    required this.category,
    required this.difficulty,
    required this.ingredientCount,
    required this.time,
    required this.likes,
    required this.ingredients,
    required this.steps,
  });
}

// 8개 레시피 데이터 모음
final List<Recipe> allRecipes = [
  Recipe(
    name: '간장계란밥',
    emoji: '🍳',
    category: '한식',
    difficulty: '간단',
    ingredientCount: 5,
    time: '5분',
    likes: 1250,
    ingredients: [
      {'name': '밥', 'amount': '1공기'},
      {'name': '계란', 'amount': '2개'},
      {'name': '간장', 'amount': '1큰술'},
      {'name': '참기름', 'amount': '1큰술'},
      {'name': '대파', 'amount': '약간'},
    ],
    steps: [
      '대파를 잘게 썰어 준비합니다.',
      '팬에 계란 프라이를 반숙으로 굽습니다.',
      '따뜻한 밥 위에 프라이와 대파를 올립니다.',
      '간장과 참기름을 넣고 맛있게 비빕니다.',
    ],
  ),
  Recipe(
    name: '원팬 토마토 파스타',
    emoji: '🍝',
    category: '양식',
    difficulty: '간단',
    ingredientCount: 6,
    time: '15분',
    likes: 2100,
    ingredients: [
      {'name': '파스타면', 'amount': '1인분'},
      {'name': '토마토 소스', 'amount': '200g'},
      {'name': '양파', 'amount': '1/4개'},
      {'name': '마늘', 'amount': '3알'},
      {'name': '베이컨', 'amount': '2줄'},
      {'name': '물', 'amount': '400ml'},
    ],
    steps: [
      '팬에 모든 재료(면 포함)와 물을 넣습니다.',
      '물이 끓기 시작하면 중불로 줄여 10분간 끓입니다.',
      '소스가 걸쭉해지면 면의 익힘 정도를 확인합니다.',
      '기호에 따라 후추나 치즈 가루를 뿌려 완성합니다.',
    ],
  ),
  Recipe(
    name: '초간단 마파두부 덮밥',
    emoji: '🥡',
    category: '중식',
    difficulty: '보통',
    ingredientCount: 6,
    time: '15분',
    likes: 890,
    ingredients: [
      {'name': '두부', 'amount': '1모'},
      {'name': '다진 돼지고기', 'amount': '100g'},
      {'name': '마파두부 소스', 'amount': '1봉'},
      {'name': '대파', 'amount': '1/2대'},
      {'name': '전분물', 'amount': '2큰술'},
      {'name': '밥', 'amount': '1공기'},
    ],
    steps: [
      '두부는 주사위 모양으로, 대파는 송송 썹니다.',
      '팬에 파기름을 내고 고기를 볶습니다.',
      '소스와 두부를 넣고 끓이다 전분물로 농도를 잡습니다.',
      '따뜻한 밥 위에 듬뿍 얹어 완성합니다.',
    ],
  ),
  Recipe(
    name: '차돌박이 된장찌개',
    emoji: '🥘',
    category: '한식',
    difficulty: '보통',
    ingredientCount: 6,
    time: '20분',
    likes: 1560,
    ingredients: [
      {'name': '차돌박이', 'amount': '150g'},
      {'name': '된장', 'amount': '2큰술'},
      {'name': '두부', 'amount': '1/2모'},
      {'name': '애호박', 'amount': '1/3개'},
      {'name': '감자', 'amount': '1개'},
      {'name': '청양고추', 'amount': '1개'},
    ],
    steps: [
      '차돌박이를 냄비에 볶아 기름을 냅니다.',
      '물을 붓고 된장을 풀어 끓입니다.',
      '딱딱한 야채(감자)부터 넣고 끓이다 두부를 넣습니다.',
      '마지막에 고추를 넣어 칼칼하게 마무리합니다.',
    ],
  ),
  Recipe(
    name: '연어 간장 포케',
    emoji: '🥗',
    category: '일식',
    difficulty: '간단',
    ingredientCount: 5,
    time: '10분',
    likes: 730,
    ingredients: [
      {'name': '연어(회용)', 'amount': '150g'},
      {'name': '아보카도', 'amount': '1/2개'},
      {'name': '어린잎 채소', 'amount': '1줌'},
      {'name': '간장 소스', 'amount': '2큰술'},
      {'name': '현미밥', 'amount': '1공기'},
    ],
    steps: [
      '연어와 아보카도를 한입 크기로 썹니다.',
      '연어를 간장 소스에 5분간 재워둡니다.',
      '그릇에 밥과 채소, 아보카도를 담습니다.',
      '양념된 연어를 올리고 남은 소스를 뿌립니다.',
    ],
  ),
  Recipe(
    name: '손님맞이 밀푀유나베',
    emoji: '🍲',
    category: '일식',
    difficulty: '어려움',
    ingredientCount: 6,
    time: '30분',
    likes: 3200,
    ingredients: [
      {'name': '소고기 불고기용', 'amount': '300g'},
      {'name': '배추', 'amount': '10장'},
      {'name': '깻잎', 'amount': '20장'},
      {'name': '청경채', 'amount': '3포기'},
      {'name': '버섯 세트', 'amount': '1팩'},
      {'name': '샤브 육수', 'amount': '1L'},
    ],
    steps: [
      '배추-깻잎-고기 순으로 겹겹이 쌓습니다.',
      '냄비 높이에 맞춰 3~4등분으로 자릅니다.',
      '냄비 가장자리부터 차곡차곡 채웁니다.',
      '중앙에 버섯을 꽂고 육수를 부어 끓입니다.',
    ],
  ),
  Recipe(
    name: '감바스 알 아히요',
    emoji: '🍤',
    category: '양식',
    difficulty: '보통',
    ingredientCount: 5,
    time: '15분',
    likes: 950,
    ingredients: [
      {'name': '자숙 새우', 'amount': '15마리'},
      {'name': '올리브유', 'amount': '200ml'},
      {'name': '마늘', 'amount': '10알'},
      {'name': '페페론치노', 'amount': '5알'},
      {'name': '바게트 빵', 'amount': '4조각'},
    ],
    steps: [
      '마늘은 편으로 썰고 새우는 물기를 뺍니다.',
      '올리브유에 마늘과 고추를 넣고 약불로 익힙니다.',
      '마늘 향이 올라오면 새우를 넣고 익힙니다.',
      '소금, 후추로 간을 하고 구운 빵과 곁들입니다.',
    ],
  ),
  Recipe(
    name: '스팸 김치볶음밥',
    emoji: '🥓',
    category: '한식',
    difficulty: '간단',
    ingredientCount: 4,
    time: '10분',
    likes: 4500,
    ingredients: [
      {'name': '스팸', 'amount': '1/2캔'},
      {'name': '신김치', 'amount': '1줌'},
      {'name': '밥', 'amount': '1공기'},
      {'name': '설탕', 'amount': '0.5큰술'},
    ],
    steps: [
      '스팸과 김치를 잘게 썹니다.',
      '팬에 스팸을 노릇하게 굽다가 김치와 설탕을 넣고 볶습니다.',
      '김치가 익으면 밥을 넣고 고루 섞으며 볶습니다.',
      '마지막에 참기름을 둘러 마무리합니다.',
    ],
  ),
];