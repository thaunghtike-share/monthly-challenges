from django.urls import path
from . import views

urlpatterns = [
    path("", views.index, name="index"),
    path("<str:month>", views.challenges, name="month-challenge"),
    path("number/<int:month>", views.challenges_by_num)
]