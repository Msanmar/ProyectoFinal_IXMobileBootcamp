package io.keepcoding.eh_ho.data.repository

import android.content.Context
import android.util.Log
import com.android.volley.NetworkError
import com.android.volley.Request
import com.android.volley.ServerError
import io.keepcoding.eh_ho.R
import io.keepcoding.eh_ho.data.service.ApiRequestQueue
import io.keepcoding.eh_ho.data.service.ApiRoutes
import io.keepcoding.eh_ho.data.service.RequestError
import io.keepcoding.eh_ho.data.service.UserRequest
import io.keepcoding.eh_ho.domain.CreateTopicModel
import io.keepcoding.eh_ho.domain.FilteredTopic
import io.keepcoding.eh_ho.domain.Topic
import org.json.JSONObject


object TopicsRepo {

    //TODO instanciar base de datos (build)

    fun getTopics(
        context: Context,
        onSuccess: (List<Topic>) -> Unit,
        onError: (RequestError) -> Unit
    ) {
        val username = UserRepo.getUsername(context)
        val request = UserRequest(
            username,
            Request.Method.GET,
            ApiRoutes.getTopics(),
            null,
            {
                it?.let {
                    onSuccess.invoke(
                        Topic.parseTopics(
                            it
                        )
                    )
                }

                if (it == null)
                    onError.invoke(
                        RequestError(
                            messageResId = R.string.error_invalid_response
                        )
                    )
            },
            {
                it.printStackTrace()
                if (it is NetworkError)
                    onError.invoke(
                        RequestError(
                            messageResId = R.string.error_network
                        )
                    )
                else
                    onError.invoke(
                        RequestError(
                            it
                        )
                    )
            })

        ApiRequestQueue.getRequestQueue(context)
            .add(request)
    }

//Get More Topics

fun getMoreTopics(
    page: Int,
    context: Context,
    onSuccess: (List<Topic>) -> Unit,
    onError: (RequestError) -> Unit
) {
    Log.d("Get More Topics_____________", page.toString())
    val username = UserRepo.getUsername(context)
    val request = UserRequest(
        username,
        Request.Method.GET,
        ApiRoutes.getMoreTopics(page),
        null,
        {
            it?.let {
                onSuccess.invoke(
                    Topic.parseTopics(
                        it
                    )
                )
            }

            if (it == null)
                onError.invoke(
                    RequestError(
                        messageResId = R.string.error_invalid_response
                    )
                )
        },
        {
            it.printStackTrace()
            if (it is NetworkError)
                onError.invoke(
                    RequestError(
                        messageResId = R.string.error_network
                    )
                )
            else
                onError.invoke(
                    RequestError(
                        it
                    )
                )
        })

    ApiRequestQueue.getRequestQueue(context)
        .add(request)
}




    fun getFilteredTopics(
        text: String,
        context: Context,
        onSuccess: (List<FilteredTopic>) -> Unit,
        onError: (RequestError) -> Unit
    ) {
        val username = UserRepo.getUsername(context)
        val request = UserRequest(
            username,
            Request.Method.GET,
            ApiRoutes.getFilteredTopics(term=text,include_blurbs = true),
            null,
            {
                it?.let {

                    Log.d("ExitoGetFilteredTopics","TopicsRepo")
                    onSuccess.invoke(
                        //Topic.parseTopics(it)
                         FilteredTopic.parseFilteredTopics(it)
                    )
                }

                if (it == null)
                    onError.invoke(
                        RequestError(
                            messageResId = R.string.error_invalid_response
                        )
                    )
            },
            {
                it.printStackTrace()
                if (it is NetworkError)
                    onError.invoke(
                        RequestError(
                            messageResId = R.string.error_network
                        )
                    )
                else
                    onError.invoke(
                        RequestError(
                            it
                        )
                    )
            })

        ApiRequestQueue.getRequestQueue(context)
            .add(request)
    }








    fun createTopic(
        context: Context,
        model: CreateTopicModel,
        onSuccess: (CreateTopicModel) -> Unit,
        onError: (RequestError) -> Unit
    ) {
        val username = UserRepo.getUsername(context)
        val request = UserRequest(
            username,
            Request.Method.POST,
            ApiRoutes.createTopic(),
            model.toJson(),
            {
                it?.let {
                    onSuccess.invoke(model)
                }

                if (it == null)
                    onError.invoke(
                        RequestError(
                            messageResId = R.string.error_invalid_response
                        )
                    )
            },
            {
                it.printStackTrace()

                if (it is ServerError && it.networkResponse.statusCode == 422) {
                    val body = String(it.networkResponse.data, Charsets.UTF_8)
                    val jsonError = JSONObject(body)
                    val errors = jsonError.getJSONArray("errors")
                    var errorMessage = ""

                    for (i in 0 until errors.length()) {
                        errorMessage += "${errors[i]} "
                    }

                    onError.invoke(
                        RequestError(
                            it,
                            message = errorMessage
                        )
                    )

                } else if (it is NetworkError)
                    onError.invoke(
                        RequestError(
                            it,
                            messageResId = R.string.error_network
                        )
                    )
                else
                    onError.invoke(
                        RequestError(
                            it
                        )
                    )
            }
        )

        ApiRequestQueue.getRequestQueue(context)
            .add(request)
    }
}