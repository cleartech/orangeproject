package orange;

import orange.entities.AlbumCategory;
import orange.services.CategoryService;
import orange.user.CustomUser;
import orange.user.UserRole;
import orange.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.Calendar;

@SpringBootApplication
public class Application {
    @Autowired
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

//    @Bean
//    public CommandLineRunner demo(final UserService userService, final CategoryService categoryService) {
//        return new CommandLineRunner() {
//            @Override
//            public void run(String... strings) throws Exception {
//                userService.addUser(new CustomUser("admin", "5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8", UserRole.ADMIN, Calendar.getInstance().getTime()));
//                userService.addUser(new CustomUser("user", "5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8", UserRole.USER, Calendar.getInstance().getTime()));
//                categoryService.addCategory(new AlbumCategory("GENERAL"));
//                categoryService.addCategory(new AlbumCategory("PEOPLE"));
//                categoryService.addCategory(new AlbumCategory("ABSTRACT"));
//                categoryService.addCategory(new AlbumCategory("NATURE"));
//                categoryService.addCategory(new AlbumCategory("AUTO"));
//            }
//        };
//    }
}