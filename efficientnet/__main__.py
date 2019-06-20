import sys

import torch

from .efficientnet import efficientnet0


torch.manual_seed(0xcafe)

net = efficientnet0()

N, C, H, W = 1, 3, 224, 224
image = torch.rand(N, C, H, W)

out = net(image)

print("It works!", file=sys.stderr)
