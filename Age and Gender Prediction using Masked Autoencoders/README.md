# Age and Gender Prediction using Masked Autoencoders

## Project Description:
In this report, we’re putting forward a new approach for age and gender prediction. Our method is based on the use of Masked Autoencoders (MAE) for initial training on the MegaAge dataset, followed by the application of transfer learning for specific tasks using the UTKFace dataset.
The key element in our proposal is the integration of pretrained MAE encoders into a Vision Transformer (ViT) model. This model has two specific parts, one for Age Regression and the other for Gender Classification. We’ve also added a BatchNorm layer before these sections to improve the model’s stability.
Our experiments have shown that this approach leads to better results. We’ve seen improved accuracy in our predictions when compared to existing methods. In summary, our proposed framework offers a significant step forward in the field of age and gender prediction.

## Proposed Architecture:
![MAE](https://github.com/virginiaphan231/DS-ML-Projects/assets/102519646/56870ae2-fe69-4219-a32a-f78d22479c26)

## Detailed Report:
[Project Report.pdf](https://github.com/virginiaphan231/DS-ML-Projects/files/11904986/Project.Report.pdf)

## References:
-  Krizhevsky, A., Sutskever, I.,Hinton, G. E. (2012). Imagenet classification with deep convolutional neural networks. Advances in neural information processing systems, 25, 1097-1105.
-  Vaswani, A., Shazeer, N., Parmar, N., Uszkoreit, J., Jones, L., Gomez, A. N.,Polosukhin, I. (2017). Attention is all you need. In Advances in neural information processing systems (pp.5998-6008).
-  He, K., Chen, X., Xie, S., Li, Y., Doll´ar, P., Girshick, R. (2021). Masked autoencoders are scalable vision learners. arXiv preprint arXiv:2111.06377.
-  Dosovitskiy, A., Beyer, L., Kolesnikov, A., Weissenborn, D., Zhai, X., Unterthiner, T.,Gelly, S. (2021). An Image is Worth 16x16 Words: Transformers for Image Recognition at Scale. arXiv:2010.11929.
