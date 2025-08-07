resource "aws_api_gateway_rest_api" "dofs" {
  name = "dofs-api"
}

resource "aws_api_gateway_resource" "order" {
  rest_api_id = aws_api_gateway_rest_api.dofs.id
  parent_id   = aws_api_gateway_rest_api.dofs.root_resource_id
  path_part   = "order"
}

resource "aws_api_gateway_method" "post" {
  rest_api_id   = aws_api_gateway_rest_api.dofs.id
  resource_id   = aws_api_gateway_resource.order.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id             = aws_api_gateway_rest_api.dofs.id
  resource_id             = aws_api_gateway_resource.order.id
  http_method             = aws_api_gateway_method.post.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = "<replace_with_lambda_uri>"
}

resource "aws_api_gateway_deployment" "dofs" {
  depends_on  = [aws_api_gateway_integration.lambda]
  rest_api_id = aws_api_gateway_rest_api.dofs.id
}

output "invoke_url" {
  value = aws_api_gateway_deployment.dofs.invoke_url
}