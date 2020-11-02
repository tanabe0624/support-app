class Occupation < ActiveHash::Base
  self.data = [
   { id: 1, name: '--' },
   { id: 2, name: '会社員' },
   { id: 3, name: '会社役員' },
   { id: 4, name: '自営業' },
   { id: 5, name: 'パート、アルバイト' },
   { id: 6, name: '専業主婦(夫)' },
   { id: 7, name: '公務員' },
   { id: 8, name: '学生' },
   { id: 9, name: 'その他' }
  ]
end
