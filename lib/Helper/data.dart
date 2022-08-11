import '../models/Category_model.dart';

List<Categorymodel> getCategory() {
  //1
  List<Categorymodel> category = <Categorymodel>[];
  Categorymodel categorymodel = Categorymodel('Business',
      'https://static.businessworld.in/article/article_extra_large_image/1614252359_YJ9qo7_businessconti_1_.jpg','Iş');
  category.add(categorymodel);
  //2

  Categorymodel categorymodel2 = Categorymodel(
      'Entertainment', 'https://i.ytimg.com/vi/u95ydHLKRgI/maxresdefault.jpg','Eğlence');
  category.add(categorymodel2);

  //3

  Categorymodel categorymodel3 = Categorymodel('General',
      'https://www.birbilenesorduk.com/wp-content/uploads/2021/09/general.jpeg','Genel');
  category.add(categorymodel3);
//4
  Categorymodel categorymodel4 = Categorymodel('Health',
      'https://www.financialexpress.com/wp-content/uploads/2022/05/GettyImages-872676342.jpg','Sağlık');
  category.add(categorymodel4);

  return category;
}
