package io.keepcoding.eh_ho.topics

import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import io.keepcoding.eh_ho.*
import io.keepcoding.eh_ho.domain.Topic
import io.keepcoding.eh_ho.home.TRANSACTION_TOPIC_FRAGMENT
import io.keepcoding.eh_ho.posts.EXTRA_TOPIC_ID
import io.keepcoding.eh_ho.posts.EXTRA_TOPIC_TITLE
import io.keepcoding.eh_ho.posts.PostsActivity


const val TRANSACTION_CREATE_TOPIC = "create_topic"

class TopicsActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("TOPICS_ACTIVITY","______________****************************************")
        setContentView(R.layout.activity_topics)
        this.title = "Eh-Ho:       Latest Topics"
        if (savedInstanceState == null) {
            supportFragmentManager.beginTransaction()
                .replace(R.id.fragmentContainer, TopicsFragment())
                .addToBackStack(TRANSACTION_TOPIC_FRAGMENT)
                .commit()
        }
    }



    //Métodos interfaz TopicsInteractionListerner
   /* override fun onTopicSelected(topic: Topic) {
       //Toast.makeText(this, topic.title, Toast.LENGTH_SHORT).show()
        goToPosts(topic)
    }*/

   /* override fun onGoToCreateTopic() {
        supportFragmentManager.beginTransaction()
            .replace(R.id.fragmentContainer, CreateTopicFragment())
            .addToBackStack(TRANSACTION_CREATE_TOPIC)
            .commit()
    }*/



   /* override fun onLogOut() {
        UserRepo.logOut(this)

        val intent = Intent(this, LoginActivity::class.java)
        startActivity(intent)
        finish()
    }

    override fun onGoToLatestPosts() {
        val intent = Intent(this, LatestPostsActivity:: class.java)
        startActivity(intent)
        finish()
    }*/



   /* override fun onTopicCreated() {
        supportFragmentManager.popBackStack()
    }*/




    private fun goToPosts(topic: Topic) {
        val intent = Intent(this, PostsActivity::class.java)
        intent.putExtra(EXTRA_TOPIC_ID, topic.id)
        intent.putExtra(EXTRA_TOPIC_TITLE, topic.title)

       // Toast.makeText(this, "Vamos a post activity", Toast.LENGTH_SHORT).show()
        startActivity(intent)
    }

}