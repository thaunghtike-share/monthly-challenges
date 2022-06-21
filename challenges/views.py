import re
from urllib import response
from django.http import HttpResponse, HttpResponseNotFound, HttpResponseRedirect, Http404
from django.shortcuts import redirect, render
from django.urls import reverse
# Create your views here.

monthly_challenges = {
    "january": "Eat no meat for the entire month!",
    "february": "Walk for at least 20 minutes every day!",
    "march": "Learn Django for at least 20 minutes every day!",
    "april": "Eat no meat for the entire month!",
    "may": "Walk for at least 20 minutes every day!",
    "june": "Learn Django for at least 20 minutes every day!",
    "july": "Eat no meat for the entire month!",
    "august": "Walk for at least 20 minutes every day!",
    "september": "Learn Django for at least 20 minutes every day!",
    "october": "Eat no meat for the entire month!",
    "november": "Walk for at least 20 minutes every day!",
    "december": None
}


def index(request):
    months = list(monthly_challenges.keys())

    return render(request, 'challenges/index.html', { 
        'months': months
    })    

def challenges_by_num(request, month):
    months=list(monthly_challenges.keys())

    if month > len(months):
        return HttpResponseNotFound("Invalid Month!")
    else:    
       redirect_month = months[month - 1]
       redirect_path = reverse("month-challenge", args=[redirect_month])
       return HttpResponseRedirect(redirect_path)

def challenges(request, month):
    try:
        challenge_text = monthly_challenges[month]    
        response_data = render(request, 'challenges/challenges.html', {
            'text': challenge_text,
            "month_name": month
        })  
        return HttpResponse(response_data)
    except:
        raise Http404()    