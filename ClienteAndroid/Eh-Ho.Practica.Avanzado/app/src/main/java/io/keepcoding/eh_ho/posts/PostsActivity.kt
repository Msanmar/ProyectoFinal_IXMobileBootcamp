package io.keepcoding.eh_ho.posts

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import io.keepcoding.eh_ho.R
import java.lang.IllegalArgumentException

const val EXTRA_TOPIC_ID = "topic_id"
const val EXTRA_TOPIC_TITLE = "topic_title"
const val TRANSACTION_CREATE_POST = "create_post"

class PostsActivity : AppCompatActivity(), PostsFragment.PostsInteractionListener, CreatePostFragment.CreatePostInteractionListener {

    var topic_ID: Int = 1
    var topic_Title: String = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_posts)

        val topicId = intent.getStringExtra(EXTRA_TOPIC_ID)
        Log.d("topicId",".........$topicId")
        val topicTitle = intent.getStringExtra(EXTRA_TOPIC_TITLE)

        if(topicId != null && topicId.isNotEmpty()) {
            topic_ID = topicId.toInt()
            topic_Title = topicTitle.toString()
            this.title = "Eh-Ho       " + topic_Title

        } else {
            throw IllegalArgumentException("You should provide an id for the topic")
        }


        if (savedInstanceState == null) {
            supportFragmentManager.beginTransaction()
                .add(R.id.fragmentContainer, PostsFragment(topic_ID, topic_Title))
                .commit()
        }


    }

    //Métodos interfaz
    override fun onGoToCreatePost(topicID: Int, topicTitle: String) {
        supportFragmentManager.beginTransaction()
            .replace(R.id.fragmentContainer,CreatePostFragment(topicID, topicTitle))
            .addToBackStack(TRANSACTION_CREATE_POST)
            .commit()
    }


    override fun onPostCreated() {
        supportFragmentManager.popBackStack()

    }

    override fun onPostSelected() {
        //TODO mostrar logo del usuario junto con el detalle del post
    }
    //-------------

}
