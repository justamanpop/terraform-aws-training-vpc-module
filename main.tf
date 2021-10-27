resource "aws_vpc" "myVPC" {
  cidr_block = var.cidr_block
  tags = {
    Name = "AnishVPC"
  }

}

resource "aws_subnet" "subnets" {
  count = length(data.aws_availability_zones.azs.names)
  vpc_id     = aws_vpc.myVPC.id
  cidr_block = "10.5.${count.index +1 }.0/24"
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  tags = {
    Name = "AnishSubnet-${count.index +1 }"
  }
}

data "aws_availability_zones" "azs"{
}

 output "azs" {
  value = data.aws_availability_zones.azs.names
 }

 output "subnets" {
   value = aws_subnet.subnets[*]
 }