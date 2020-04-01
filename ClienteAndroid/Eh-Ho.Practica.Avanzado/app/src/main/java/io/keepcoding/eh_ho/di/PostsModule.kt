package io.keepcoding.eh_ho.di

import android.content.Context
import dagger.Module
import dagger.Provides
import io.keepcoding.eh_ho.data.repository.PostsRepo
import io.keepcoding.eh_ho.database.PostsDatabase
import javax.inject.Singleton

@Module
class PostsModule {

    @Singleton
    @Provides

  fun providePostRepo(context: Context, postDatabase: PostsDatabase): PostsRepo {
        PostsRepo.ctx = context
        PostsRepo.db = postDatabase
        return PostsRepo
    }

}
