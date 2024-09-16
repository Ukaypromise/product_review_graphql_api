### SignUp
```ruby
mutation signUp{
  userCreate(input: {
    username: "promise",
    authProvider:{
      credentials:{
        email: "promise@gmail.com",
        password: "123456"
      }
    }
    
  }){
    user{
      id
      username
      email
    }
  }
}
```
### signInUser
```ruby
mutation signInUser{
  signInUser(input: {
    credentials:{
        email: "promise@gmail.com",
        password: "123456"
      }
  }){
    user{
      id
      username
      email
    }
    token
  }
}
```
### AddProduct
```ruby
mutation AddProduct{
  createProduct(input: {
    name: "Samsung s10 ",
    url: "www.samsung.com/10"
  }){
    product{
      id
      name
      url
      createdAt
      reviewRequestedBy{
        username
      }
    }
    errors
  }
}
```
### AddComment
```ruby
mutation AddComment{
  commentCreate(input: {
    body: "I love this product.",
    productId: 1
  }){
    comment{
      id
      body
      createdAt
      user{
        id
        email
      }
      product{
        id
        name
      }
    }
    errors
  }
}
```
### UpdateComment
```ruby
mutation UpdateComment{
  commentUpdate(input: {id: 1, body:"I just changed this again"}){
    comment{
      id
      body
      user{
        username
      }
      product{
        name
        url
      }
    }
  }
}
```
### DeleteComment
```ruby
mutation DeleteComment{
  commentDelete(input: {id: 4}){
    success
  }
}
```
### GetProduct
```ruby
query GetProduct{
  product(id: 1){
    id
    name
    url
    reviewRequestedBy{
      id
      username
      email
    }
    commentCount
    comments{
      id
      body
    }
  }
}
```
### search
```ruby
query search{
  searchProducts(filter: {
    nameContains: "Samsung s24"
  }) {
    id
    name
    comments{
      body
    }
  }
}
```

```ruby
query GetallProductPaginated{
  allProducts(page: 2, limit: 2){
    collection{
      id
      name
      url
    }
    metadata {
      totalPages
      totalCount
      currentPage
      limitValue
    }
    
  }
}
```