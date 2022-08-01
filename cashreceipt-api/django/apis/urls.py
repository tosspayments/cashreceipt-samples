from django.urls import path
from . import views

urlpatterns = [
  path('', views.index),

  path('cashreceipt', views.cashreceipt),
  path('cancelcashreceipt', views.cancelcashreceipt),
]