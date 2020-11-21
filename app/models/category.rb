class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '人間関係' },
    { id: 3, name: '健康' },
    { id: 4, name: 'お金' },
    { id: 5, name: '子育て' },
    { id: 6, name: '夫婦仲' },
    { id: 7, name: '介護' },
    { id: 8, name: '恋愛' },
    { id: 9, name: 'その他' }
  ]
end
