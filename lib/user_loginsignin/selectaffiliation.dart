import 'package:flutter/material.dart';

class SelectAffWidget extends StatefulWidget {
  const SelectAffWidget({Key? key}) : super(key: key);

  @override
  State<SelectAffWidget> createState() => _SelectAffWidgetState();
}

class _SelectAffWidgetState extends State<SelectAffWidget> {
  String _selectedCountry = '서울';
  Map<String, String> country = {
    '서울': 'seoul',
    '부산': 'busan',
    '대구': 'daegu',
    '인천': 'incheon',
    '광주': 'gwangju',
    '대전': 'daejeon',
    '울산': 'ulsan',
    '세종': 'sejong',
    '강원도': 'kangwondo',
    '경기도': 'gyunggido',
    '충청북도': 'chungchungb',
    '충청남도': 'chungchungn',
    '전라북도': 'jeonrab',
    '전라남도': 'jeonran',
    '경상북도': 'kyungsangb',
    '경상남도': 'kyungsangn',
    '제주도': 'jeju',
  };

  final List _countries = [];
  countryDependentDropdown() {
    country.forEach((key, value) {
      _countries.add(key);
    });
  }

  String? _selectedAff = '';
  Map<String, String> affiliation = {
    '강남구': 'seoul',
    '강동구': 'seoul',
    '강북구': 'seoul',
    '강서구': 'seoul',
    '관악구': 'seoul',
    '광진구': 'seoul',
    '구로구': 'seoul',
    '금천구': 'seoul',
    '노원구': 'seoul',
    '도봉구': 'seoul',
    '동대문구': 'seoul',
    '동작구': 'seoul',
    '마포구': 'seoul',
    '서대문구': 'seoul',
    '서초구': 'seoul',
    '성동구': 'seoul',
    '성북구': 'seoul',
    '송파구': 'seoul',
    '양천구': 'seoul',
    '영등포구': 'seoul',
    '용산구': 'seoul',
    '은평구': 'seoul',
    '종로구': 'seoul',
    '중구': 'seoul',
    '중랑구': 'seoul',
    //
    '강서구(부산)': 'busan',
    '금정구': 'busan',
    '기장군': 'busan',
    '남구': 'busan',
    '동구': 'busan',
    '동래구': 'busan',
    '부산진구': 'busan',
    '북구': 'busan',
    '사상구': 'busan',
    '사하구': 'busan',
    '서구': 'busan',
    '수영구': 'busan',
    '연제구': 'busan',
    '영도구': 'busan',
    '중구(부산)': 'busan',
    '해운대구': 'busan',
    //
    '남구(대구)': 'daegu',
    '달서구': 'daegu',
    '달성군': 'daegu',
    '동구(대구)': 'daegu',
    '북구(대구)': 'daegu',
    '서구(대구)': 'daegu',
    '수성구': 'daegu',
    '중구(대구)': 'daegu',
    //
    '강화군': 'incheon',
    '계양구': 'incheon',
    '남동구': 'incheon',
    '동구(인천)': 'incheon',
    '미추홀구': 'incheon',
    '부평구': 'incheon',
    '서구(인천)': 'incheon',
    '연수구': 'incheon',
    '옹진군': 'incheon',
    '중구(인천)': 'incheon',
    //
    '광산구': 'gwangju',
    '남구(광주)': 'gwangju',
    '동구(광주)': 'gwangju',
    '북구(광주)': 'gwangju',
    '서구(광주)': 'gwangju',
    //
    '대덕구': 'daejeon',
    '동구(대전)': 'daejeon',
    '서구(대전)': 'daejeon',
    '유성구': 'daejeon',
    '중구(대전)': 'daejeon',
    //
    '남구(울산)': 'ulsan',
    '동구(울산)': 'ulsan',
    '북구(울산)': 'ulsan',
    '울주군': 'ulsan',
    '중구(울산)': 'ulsan',
    //
    '세종시': 'sejong',
    //
    '강릉시': 'kangwondo',
    '고성군': 'kangwondo',
    '동해시': 'kangwondo',
    '삼척시': 'kangwondo',
    '속초시': 'kangwondo',
    '양구군': 'kangwondo',
    '양양군': 'kangwondo',
    '영월군': 'kangwondo',
    '원주시': 'kangwondo',
    '인제군': 'kangwondo',
    '정선군': 'kangwondo',
    '철원군': 'kangwondo',
    '춘천시': 'kangwondo',
    '태백시': 'kangwondo',
    '평창군': 'kangwondo',
    '홍천군': 'kangwondo',
    '화천군': 'kangwondo',
    '횡성군': 'kangwondo',
    //
    '가평군': 'gyunggido',
    '고양시 덕양구': 'gyunggido',
    '고양시 일산동구': 'gyunggido',
    '고양시 일산서구': 'gyunggido',
    '과천시': 'gyunggido',
    '광명시': 'gyunggido',
    '광주시': 'gyunggido',
    '구리시': 'gyunggido',
    '군포시': 'gyunggido',
    '김포시': 'gyunggido',
    '남양주시': 'gyunggido',
    '동두천시': 'gyunggido',
    '부천시': 'gyunggido',
    '성남시 분당구': 'gyunggido',
    '성남시 수정구': 'gyunggido',
    '성남시 중원구': 'gyunggido',
    '수원시 권선구': 'gyunggido',
    '수원시 영통구': 'gyunggido',
    '수원시 장안구': 'gyunggido',
    '수원시 팔달구': 'gyunggido',
    '시흥시': 'gyunggido',
    '안산시 단원구': 'gyunggido',
    '안산시 상록구': 'gyunggido',
    '안성시': 'gyunggido',
    '안양시 동안구': 'gyunggido',
    '안양시 만안구': 'gyunggido',
    '양주시': 'gyunggido',
    '양평군': 'gyunggido',
    '여주시': 'gyunggido',
    '연천군': 'gyunggido',
    '오산시': 'gyunggido',
    '용인시 기흥구': 'gyunggido',
    '용인시 수지구': 'gyunggido',
    '용인시 처인구': 'gyunggido',
    '의왕시': 'gyunggido',
    '의정부시': 'gyunggido',
    '이천시': 'gyunggido',
    '파주시': 'gyunggido',
    '평택시': 'gyunggido',
    '포천시': 'gyunggido',
    '하남시': 'gyunggido',
    '화성시': 'gyunggido',
    //
    '괴산군': 'chungchungb',
    '단양군': 'chungchungb',
    '보은군': 'chungchungb',
    '영동군': 'chungchungb',
    '옥천군': 'chungchungb',
    '음성군': 'chungchungb',
    '제천시': 'chungchungb',
    '증평군': 'chungchungb',
    '진천군': 'chungchungb',
    '청주시 상당구': 'chungchungb',
    '청주시 서원구': 'chungchungb',
    '청주시 청원구': 'chungchungb',
    '청주시 흥덕구': 'chungchungb',
    '충주시': 'chungchungb',
    //
    '계룡시': 'chungchungn',
    '공주시': 'chungchungn',
    '금산시': 'chungchungn',
    '논산시': 'chungchungn',
    '당진시': 'chungchungn',
    '보령시': 'chungchungn',
    '부여군': 'chungchungn',
    '서산시': 'chungchungn',
    '서천군': 'chungchungn',
    '아산시': 'chungchungn',
    '예산군': 'chungchungn',
    '천안시 동남구': 'chungchungn',
    '천안시 서북구': 'chungchungn',
    '청양군': 'chungchungn',
    '태안군': 'chungchungn',
    '홍성군': 'chungchungn',
    //
    '고창군': 'jeonrab',
    '군산시': 'jeonrab',
    '김제시': 'jeonrab',
    '남원시': 'jeonrab',
    '무주군': 'jeonrab',
    '부안군': 'jeonrab',
    '순창군': 'jeonrab',
    '완주군': 'jeonrab',
    '익산시': 'jeonrab',
    '임실군': 'jeonrab',
    '장수군': 'jeonrab',
    '전주시 덕진구': 'jeonrab',
    '전주시 완산구': 'jeonrab',
    '정읍시': 'jeonrab',
    '진안군': 'jeonrab',
    //
    '강진군': 'jeonran',
    '고흥군': 'jeonran',
    '곡성군': 'jeonran',
    '광양시': 'jeonran',
    '구례군': 'jeonran',
    '나주시': 'jeonran',
    '담양군': 'jeonran',
    '목포시': 'jeonran',
    '무안군': 'jeonran',
    '보성군': 'jeonran',
    '순천시': 'jeonran',
    '신안군': 'jeonran',
    '여수시': 'jeonran',
    '영광군': 'jeonran',
    '영암군': 'jeonran',
    '완도군': 'jeonran',
    '장성군': 'jeonran',
    '장흥군': 'jeonran',
    '진도군': 'jeonran',
    '함평군': 'jeonran',
    '해남군': 'jeonran',
    '화순군': 'jeonran',
    //
    '경산시': 'kyungsangb',
    '경주시': 'kyungsangb',
    '고령군': 'kyungsangb',
    '구미시': 'kyungsangb',
    '군위군': 'kyungsangb',
    '김천시': 'kyungsangb',
    '문경시': 'kyungsangb',
    '봉화군': 'kyungsangb',
    '상주시': 'kyungsangb',
    '성주군': 'kyungsangb',
    '안동시': 'kyungsangb',
    '영덕군': 'kyungsangb',
    '영양군': 'kyungsangb',
    '영주시': 'kyungsangb',
    '영천시': 'kyungsangb',
    '예천군': 'kyungsangb',
    '울릉군': 'kyungsangb',
    '울진군': 'kyungsangb',
    '의성군': 'kyungsangb',
    '청도군': 'kyungsangb',
    '청송군': 'kyungsangb',
    '칠곡군': 'kyungsangb',
    '포항시 남구': 'kyungsangb',
    '포항시 북구': 'kyungsangb',
    //
    '거제시': 'kyungsangn',
    '거창군': 'kyungsangn',
    '고성군(경남)': 'kyungsangn',
    '김해시': 'kyungsangn',
    '남해군': 'kyungsangn',
    '밀양시': 'kyungsangn',
    '사천시': 'kyungsangn',
    '산청군': 'kyungsangn',
    '양산시': 'kyungsangn',
    '의령군': 'kyungsangn',
    '진주시': 'kyungsangn',
    '창녕군': 'kyungsangn',
    '창원시 마산합포구': 'kyungsangn',
    '창원시 마산회원구': 'kyungsangn',
    '창원시 성산구': 'kyungsangn',
    '창원시 의창구': 'kyungsangn',
    '창원시 진해구': 'kyungsangn',
    '통영시': 'kyungsangn',
    '하동군': 'kyungsangn',
    '함안군': 'kyungsangn',
    '함양군': 'kyungsangn',
    '합천군': 'kyungsangn',
    //
    '제주시': 'jeju',
    '서귀포시': 'jeju',
  };

  List _affiliations = [];
  affiliationDependentDropdown(countryShortName) {
    affiliation.forEach((key, value) {
      if (countryShortName == value) {
        _affiliations.add(key);
      }
    });
    _selectedAff = _affiliations[0];
  }

  @override
  void initState() {
    super.initState();
    countryDependentDropdown();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 3),
          DropdownButton(
            menuMaxHeight: 300,
            isExpanded: true,
            hint: const Text('지역'),
            borderRadius: BorderRadius.circular(20),
            onChanged: (newValue) {
              setState(() {
                _affiliations = [];
                affiliationDependentDropdown(country[newValue]);
                _selectedCountry = '$newValue';
              });
            },
            value: _selectedCountry,
            items: _countries.map((country) {
              return DropdownMenuItem(
                child: Text(country),
                value: country,
              );
            }).toList(),
          ),
          const SizedBox(height: 5),
          DropdownButton(
            menuMaxHeight: 300,
            isExpanded: true,
            hint: const Text('소속'),
            borderRadius: BorderRadius.circular(20),
            onChanged: (newValue) {
              setState(() {
                _selectedAff = '$newValue';
                myAffiliation = '$_selectedCountry $_selectedAff';
              });
            },
            value: _selectedAff,
            items: _affiliations.map((country) {
              return DropdownMenuItem(
                child: Text(country),
                value: country,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

String? myAffiliation;
